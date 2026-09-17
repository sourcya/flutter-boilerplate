---
name: flutter-model-generator
description: Generates Flutter API models, UI models, and mappers using safe parsing, Equatable, and clean architecture. Use when given JSON, API class, or UI model.
---

# Flutter Model Generator

This skill generates missing layers for data models in Flutter apps.

Supported inputs:
- JSON object
- API model (ApiX)
- UI model (UiX)

Output:
- API model (if missing)
- UI model (if missing)
- Mapper (always generated)

---

# 🧱 API Model Rules (ApiX)

## Structure

- Class name must start with `Api`
- Fields must EXACTLY match API response
- All fields nullable unless guaranteed

## Parsing

Use safe convert helpers from the `playx` package:

- `asInt` / `asIntOrNull`
- `asString` / `asStringOrNull`
- `asBool` / `asBoolOr`
- `asDouble` / `asDoubleOrNull`
- `asLocalDateTime` / `asLocalDateTimeOrNull`

## Requirements

- factory fromJson(dynamic json)
- Map<String, dynamic> toJson()
- No business logic
- No transformations

---

# 🎯 UI Model Rules (UiX)

## Structure

- Clean, immutable model
- Extends Equatable
- Contains transformed fields

## Transformations

- String → Enum (recommended)
- String date → DateTime
- Derived fields allowed:
  - fullName
  - formattedDate
  - status flags

## Requirements

- `copyWith()`
- `props` override
- `toString()` override
- clean naming

## File Rule

- Each UI model must be in a separate file

---

# 🔄 Mapper Rules (XMapper)

## Responsibilities

- Convert Api → Ui
- Convert Ui → Api

## Requirements

- Handle null safety properly
- Apply all transformations
- **Crucial**: Implement mappers as `extension` methods, NOT as separate classes.

## Extension Patterns to Generate:

Provide these specific extensions:

1. `extension ApiXMapper on ApiX` (adds `toUi()` method)
2. `extension ApiXListMapper on List<ApiX>` (adds `toUiList()` method)
3. `extension XUiMapper on UiX` (adds `toApi()` method)
4. `extension XUiListMapper on List<UiX>` (adds `toApiList()` method)

---

# 🧠 Smart Decisions

When generating models:

- Detect enums automatically from string fields like:
  - status
  - type
  - role

- Suggest enums but DO NOT assume silently

---

# ⚠️ Enum Rule (IMPORTANT)

If enum is detected:

- STOP and ask user:

"Do you want to convert this field into an enum?"

Only proceed after confirmation OR provide both options.

---

# 🧾 Output Structure (STRICT)

Always return:

1. API model (if missing)
2. UI model
3. Mapper

If enum is suggested:
4. Enum definition

---

# 🔍 JSON Handling

- Respect nested structures
- Support dot notation if needed
- Handle lists properly using:
  asList / asListOrNull

---

# ⚠️ Anti-Patterns

❌ No logic inside API model  
❌ No raw JSON usage in UI  
❌ No direct API → UI mapping without mapper  
❌ No mutable UI models  

---

# 🧾 Example Behavior

Input:
JSON with "status": "pending"

Output:
- Suggest VisitStatus enum
- Ask for confirmation
- Generate models accordingly

---

# 🚀 Output Quality

- Production-ready code
- Clean naming
- Minimal but complete
- Follows null safety strictly
