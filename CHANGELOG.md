# flutter_protector (0.6.0)

## 📜 Changelog


## [0.6.0] - 2025-05-21

### Added
- New method: `checkEmu` for improved emulator result mapping. 

### Changed
- Updated core logic for better performance and reliability.
- Improved security in emulator detection scoring system.
- Data structure updated to strengthen protection against reverse engineering.
- Encrypted data communication between Android and platform channels.

### Removed
- Deprecated method `isEmulatorSuper` has been removed. 

### Fixed
- Minor bugs resolved to enhance stability.

### Security
- Enhanced protection to restrict code visibility during reverse engineering attempts.


### [0.5.0] - 2025-05-10
- Fixed Bug
- Update Core

### [0.4.7] - 2025-05-10
- Fixed Bug
- Update Core
 
### [0.4.7] - 2025-05-4
- Fixed Bug

### [0.4.6] - 2025-05-4
- Fixed Bug
- Update Emulator
- Update Core

### [0.4.3] - 2025-04-29
- Added support for:
    - fix bug on tablet detection


### [0.4.0] - 2025-04-29
- Added support for:
    - Opening Developer Options
    - Opening VPN Settings
    - Opening Bluetooth Settings
    - Opening Display Settings
    - Opening Sound Settings
    - Opening Data Usage Settings
    - Opening Security Settings
    - Opening Accessibility Settings
    - Opening Location Settings
    - Battery Optimization Status Check
    - Requesting to Disable Battery Optimization
    - Screenshot Security Toggle
- Added platform delegation methods in `FlutterProtector` class
- Fixed bug on tablet detection

### [0.3.7] - 2025-05-1
- Fixed Bug 
- Details Emulator Check

### [0.3.7] - 2025-04-27
- Fixed Bug Tablet

### [0.3.6] - 2025-04-26
- Improved emulator detection.
- Added security detail result checks.
- Fixed issues on Samsung devices (A21, A10, A31, A52, A51).
- Updated native C++ library.
- Released the new package version.

### [0.3.1] - 2025-02-19
- Released package update.
- Enhanced emulator checks.
- Added `checkTelephonyManager` and `isBlueStacks` methods.

### [0.1.2] - 2025-01-20
- Released package update.
- Improved example and test files.
- Verified functionality on Samsung, Xiaomi, Huawei, Realme, Motorola devices.

### [0.1.2] - 2025-01-18
- Released package update.
- Disabled app screenshots for better security.

### [0.1.2] - 2025-01-15
- Added `isEmulatorSuper` support for Android 6 to Android 15.

### [0.1.0] - 2025-01-12
- Updated OS build data retrieval.
- Added device ID fetching for build info.
- Implemented IMEI and enhanced emulator detection.
- Updated README documentation.

### [0.0.6] - 2025-01-12
- Updated build data OS functionality.
- Fixed emulator detection bugs.

### [0.0.5] - 2025-01-12
- Minor bug fixes and performance improvements.
- Removed web platform support.

### [0.0.3] - 2025-01-12
- Minor bug fixes and optimizations.

### [0.0.2+2] - 2025-01-12
- Added:
    - Emulator detection
    - Root/Jailbreak detection
    - VPN/Proxy detection
    - Sniffing apps detection
    - Public and local IP check
- Minor bug fixes.

### [0.0.2] - 2025-01-01
- Initial release of the flutter_protector plugin with basic security features.

