# VinuOS v25B13

## Was ist VinuOS?

VinuOS ist ein Community-basiertes Lernprojekt, das als einfaches Betriebssystem dient. Jeder kann es herunterladen, testen und verbessern. Ziel ist es, gemeinsam mehr über Betriebssystementwicklung zu lernen.

## Status

Das Projekt ist noch in einer frühen Phase. VinuOS kann gestartet werden, grundlegende Eingaben über Knöpfe sind möglich, aber der Funktionsumfang ist noch sehr begrenzt.

## Technische Details

- **Version:** v25B13
- **Sprachen:** Assembly, C
- **Image-Datei:** `disk.img`

## Voraussetzungen

- QEMU
- Make

## Installation & Start

1. Repository klonen:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```
2. Kompilieren:
   ```bash
   make
   ```
3. Starten:
   ```bash
   make run
   ```

Alternativ kann VinuOS auch manuell mit QEMU gestartet werden:

```bash
qemu-system-x86_64 -drive format=raw,file=disk.img
```

## Screenshots

Die aktuellen Screenshots befinden sich im Ordner `screenshots`:

- `v25B13.png`
- `v25B1end.png`

## Mitarbeit

VinuOS ist ein Community-Projekt – Beiträge, Ideen und Verbesserungen sind willkommen!