Moin,

ich habe mal ein Makefile für die M4 Sheets gebaut.

Gegenüber Martins Skripten hat es folgende Vorteile:
 - Die Position der rules- und character-Verzeichnisse ist frei konfigurierbar
 - Das character-Verzeichnis wird nicht angetastet und kann theoretisch sogar readonly sein.
 - Damit ist es dann auch ohne Probleme unabhängig versionierbar.
 - Es ruft keine X11-Tools auf.
 - Es ist einfach erweiterbar und unterstützt beliebige Output-Formate

Ich verwende folgendes Verzeichnis-Layout:

  <basis-dir>
  +---DaD_M4_Rules_20130119
  |   +---rules
  |   |   +--- ...
  +---DaD_M4_Rules_Latest -> DaD_M4_Rules_20130119
  +---Characters
  |   +---char_hannah.m4
  |   +---char_hannah.inc
  |   +--- ...
  +---Working
      +---Makefile
      +---char_hannah.ps

Benutzung:
 - Makefile in ein Arbeitsverzeichnis kopieren.
 - Im Makefile oben die rules- und character-Verzeichnisse eintragen. (Ich verwende
   DaD_M4_Rules_Latest und passe ggf. den Link an.)
 - Optional: Unten das default-Format, die Characternamen und die default-Regel anpassen.
 - Benutzung: Im Working-Verzeichnis: "make <name>" oder "make char_<name>.pdf"

Viel Spass.
