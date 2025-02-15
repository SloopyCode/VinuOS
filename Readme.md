# VinuOS v25B13

## What is VinuOS?

VinuOS is a community-based learning project that serves as a simple operating system. Everyone can download, test, and improve it. If you have made improvements or have suggestions, please submit a pull request or upload your improved version to your own GitHub repository. The goal is to learn more about operating system development togeth

## Status

The project is still in an early phase. VinuOS can be started, basic inputs are possible, but the functionality is still very limited.

## Technical Details

- **Version:** v25B13
- **Languages:** Assembly, C
- **Image File:** `disk.img`

## Requirements

- QEMU
- Make

## Installation & Start

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```
2. Compile:
   ```bash
   make
   ```
3. Start:
   ```bash
   make run
   ```

Alternatively, VinuOS can also be started manually with QEMU:

```bash
qemu-system-x86_64 -drive format=raw,file=disk.img
```

## Screenshots

The current screenshots are located in the `screenshots` folder:

- `v25B13.png`
- `v25B1end.png`

## Contribution

VinuOS is a community project – contributions, ideas, and improvements are welcome!



