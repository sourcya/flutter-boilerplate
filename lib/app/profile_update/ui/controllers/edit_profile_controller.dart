part of '../imports/profile_imports.dart';

class EditProfileController extends GetxController {
  // Dependencies
  final ProfileRepository _profileRepository = ProfileRepository.instance;

  // Text Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Focus Nodes
  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();

  // Reactive Variables
  final Rx<bool> isLoading = Rx(false);
  final Rx<bool> isSaving = Rx(false);
  final Rx<bool> hasChanges = Rx(false);
  final Rx<bool> isFormValid = Rx(false);

  // Field Validation - Remove individual field validation observables
  // We'll compute these on-demand instead of storing them

  // Image Management
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString currentImageUrl = ''.obs;

  // Original data for comparison
  ApiUserInfo? _originalUserInfo;

  // Image picker
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _initializeController();
    _setupImageChangeListener();
  }

  @override
  void onClose() {
    _disposeControllers();
    super.onClose();
  }

  /// Initialize controller with user data
  Future<void> _initializeController() async {
    try {
      isLoading.value = true;

      // Get user profile
      final result = await _profileRepository.getUserProfile();

      result.when(
        success: (ApiUserInfo userInfo) {
          _originalUserInfo = userInfo;
          _populateFields(userInfo);
        },
        error: (NetworkException error) {
          _handleError(error);
        },
      );
    } catch (e) {
      _handleError(const UnexpectedErrorException(
        errorMessage: 'Failed to load profile data',
      ));
      Sentry.captureException(e);
    } finally {
      isLoading.value = false;
    }
  }

  /// Setup only image change listener (since it's not tied to text fields)
  void _setupImageChangeListener() {
    selectedImage.listen((file) {
      _checkForChanges();
    });
  }

  /// Check if form has changes
  void _checkForChanges() {
    if (_originalUserInfo == null) {
      hasChanges.value = false;
      return;
    }

    final hasTextChanges =
        firstNameController.text != (_originalUserInfo!.firstName ?? '') ||
            lastNameController.text != (_originalUserInfo!.lastName ?? '') ||
            emailController.text != (_originalUserInfo!.email ?? '') ||
            phoneController.text != (_originalUserInfo!.mobileNumber ?? '');

    final hasImageChange = selectedImage.value != null;

    hasChanges.value = hasTextChanges || hasImageChange;
  }

  /// Populate form fields with user data
  void _populateFields(ApiUserInfo userInfo) {
    firstNameController.text = userInfo.firstName ?? '';
    lastNameController.text = userInfo.lastName ?? '';
    emailController.text = userInfo.email ?? '';
    phoneController.text = userInfo.mobileNumber ?? '';

    currentImageUrl.value = userInfo.image?.url ?? '';

    // Reset change tracking and validate form
    hasChanges.value = false;
    _validateForm();
  }

  /// Handle field changes - called directly from UI
  void onFieldChanged(String fieldName, String value) {
    // Update the controller if needed (though this should happen automatically)
    _checkForChanges();
    _validateForm();
  }

  /// Validate entire form - compute validation on-demand
  void _validateForm() {
    isFormValid.value =
        isFirstNameValid && isLastNameValid && isEmailValid && isPhoneValid;
  }

  /// Validation Getters - Compute validation on-demand instead of storing
  bool get isFirstNameValid => _validateFirstName(firstNameController.text);
  bool get isLastNameValid => _validateLastName(lastNameController.text);
  bool get isEmailValid => _validateEmail(emailController.text);
  bool get isPhoneValid => _validatePhone(phoneController.text);

  /// Get field validation status for UI
  bool isFieldValid(String fieldName) {
    switch (fieldName) {
      case 'firstName':
        return isFirstNameValid;
      case 'lastName':
        return isLastNameValid;
      case 'email':
        return isEmailValid;
      case 'phone':
        return isPhoneValid;
      default:
        return true;
    }
  }

  /// Get validation error message for a field
  String? getFieldErrorMessage(String fieldName) {
    switch (fieldName) {
      case 'firstName':
        return isFirstNameValid ? null : _getFirstNameError();
      case 'lastName':
        return isLastNameValid ? null : _getLastNameError();
      case 'email':
        return isEmailValid ? null : _getEmailError();
      case 'phone':
        return isPhoneValid ? null : _getPhoneError();
      default:
        return null;
    }
  }

  /// Validation Methods
  bool _validateFirstName(String value) {
    return value.trim().isNotEmpty && value.trim().length >= 2;
  }

  bool _validateLastName(String value) {
    return value.trim().isNotEmpty && value.trim().length >= 2;
  }

  bool _validateEmail(String value) {
    if (value.trim().isEmpty) return false;
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(value.trim());
  }

  bool _validatePhone(String value) {
    // Phone is optional
    if (value.trim().isEmpty) return true;

    // Basic phone validation (adjust regex as needed)
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
    return phoneRegex.hasMatch(value.trim());
  }

  /// Error message getters
  String _getFirstNameError() {
    final value = firstNameController.text;
    if (value.trim().isEmpty) return 'First name is required';
    if (value.trim().length < 2) {
      return 'First name must be at least 2 characters';
    }
    return 'Invalid first name';
  }

  String _getLastNameError() {
    final value = lastNameController.text;
    if (value.trim().isEmpty) return 'Last name is required';
    if (value.trim().length < 2) {
      return 'Last name must be at least 2 characters';
    }
    return 'Invalid last name';
  }

  String _getEmailError() {
    final value = emailController.text;
    if (value.trim().isEmpty) return 'Email is required';
    return 'Please enter a valid email address';
  }

  String _getPhoneError() {
    return 'Please enter a valid phone number';
  }

  /// Force validation update - call this when you need to refresh validation state
  void updateValidation() {
    _validateForm();
  }

  /// Show image picker dialog
  Future<void> showImagePicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => _buildImagePickerSheet(context),
    );
  }

  /// Build image picker sheet
  Widget _buildImagePickerSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: context.colors.onSurface.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),

          CustomText(
            'Select Profile Photo',
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: context.colors.onSurface,
          ),
          SizedBox(height: 20.h),

          Row(
            children: [
              Expanded(
                child: _buildPickerOption(
                  context,
                  icon: Icons.camera_alt_outlined,
                  title: 'Camera',
                  onTap: () => _pickImage(ImageSource.camera, context),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildPickerOption(
                  context,
                  icon: Icons.photo_library_outlined,
                  title: 'Gallery',
                  onTap: () => _pickImage(ImageSource.gallery, context),
                ),
              ),
            ],
          ),

          if (currentImageUrl.value.isNotEmpty ||
              selectedImage.value != null) ...[
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: _buildPickerOption(
                context,
                icon: Icons.delete_outline,
                title: 'Remove Photo',
                color: Colors.red,
                onTap: () => _removeImage(context),
              ),
            ),
          ],

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  /// Build picker option button
  Widget _buildPickerOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    final optionColor = color ?? context.colors.primary;

    return CustomElevatedButton(
      onPressed: onTap,
      color: optionColor.withValues(alpha: 0.1),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      borderRadius: BorderRadius.circular(16.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24.r,
            color: optionColor,
          ),
          SizedBox(height: 8.h),
          CustomText(
            title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: optionColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Pick image from source
  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        _checkForChanges();

        // Add haptic feedback
        HapticFeedback.selectionClick();
      }

      PlayxNavigation.pop();
    } catch (e) {
      PlayxNavigation.pop();
      Alert.error(
        message: 'Failed to pick image. Please try again.',
        duration: const Duration(seconds: 2),
      );
      Sentry.captureException(e);
    }
  }

  /// Remove current image
  void _removeImage(BuildContext context) {
    selectedImage.value = null;
    currentImageUrl.value = '';
    _checkForChanges();

    HapticFeedback.selectionClick();
    PlayxNavigation.pop(); // Close picker sheet

    Alert.success(
      message: 'Profile photo removed',
      duration: const Duration(seconds: 1),
    );
  }

  /// Save profile changes
  Future<bool> saveProfile() async {
    if (!isFormValid.value || !hasChanges.value || isSaving.value) {
      return false;
    }

    try {
      isSaving.value = true;

      final result = await _profileRepository.updateProfile(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        mobileNumber: phoneController.text.trim().isEmpty
            ? null
            : phoneController.text.trim(),
        profileImageFile: selectedImage.value,
      );

      if (result is NetworkSuccess<ApiUserInfo>) {
        // Update original data
        _originalUserInfo = result.data;
        selectedImage.value = null;
        hasChanges.value = false;

        // Update current image URL if changed
        if (result.data.image?.url != null) {
          currentImageUrl.value = result.data.image!.url!;
        }

        return true;
      } else {
        final error = (result as NetworkError<ApiUserInfo>).error;
        _handleError(error);
        return false;
      }
    } catch (e) {
      _handleError(
        const UnexpectedErrorException(errorMessage: 'Failed to save profile'),
      );
      Sentry.captureException(e);
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  /// Handle errors
  void _handleError(NetworkException error) {
    String message = 'An error occurred';

    if (error is ApiException) {
      message = error.errorMessage.isEmpty
          ? 'Server error occurred'
          : error.errorMessage;
    } else if (error is UnauthorizedRequestException) {
      message = 'Session expired. Please login again.';
      // Optionally redirect to login
    } else if (error is TimeoutException) {
      message = 'Request timed out. Please check your connection.';
    } else if (error is NoInternetConnectionException) {
      message = 'No internet connection. Changes saved for sync.';
    }

    Alert.success(message: message);
  }

  /// Dispose controllers and focus nodes
  void _disposeControllers() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    firstNameFocus.dispose();
    lastNameFocus.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
  }

  /// Refresh profile data
  Future<void> refreshProfile() async {
    await _initializeController();
  }

  /// Check if user has pending offline changes
  Future<bool> checkPendingUpdates() async {
    return await _profileRepository.hasPendingUpdates();
  }

  /// Sync pending updates when online
  Future<void> syncPendingUpdates() async {
    final success = await _profileRepository.syncPendingUpdates();
    if (success) {
      await refreshProfile();
      Alert.success(
        message: 'Profile synchronized successfully',
        duration: const Duration(seconds: 2),
      );
    }
  }
}
