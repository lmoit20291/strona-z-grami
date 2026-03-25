#  Strona z grami

Projekt szkolny polegający na stworzeniu platformy z grami przeglądarkowymi, podobnej do itch.io.

##  Funkcje (aktualnie)
- wyświetlanie listy gier
- możliwość uruchomienia gry w przeglądarce
- podstawowa struktura frontend + backend

## Technologie
- HTML
- CSS
- JavaScript
- PHP
- MySQL

##  Struktura projektu
- frontend/ – strona użytkownika
- backend/ – logika aplikacji (API)
- database/ – baza danych
- games/ – gry

##  Jak uruchomić
1. Pobierz repozytorium
2. Uruchom XAMPP (Apache + MySQL)
3. Wgraj projekt do folderu htdocs
4. Otwórz w przeglądarce:
   http://localhost/strona-z-grami/frontend/

##  Autorzy
- Maksym Ratajczak
- Igor Ratajczak
- Kacper Strzyżewski
- Dawid Zachaś

## Status
Projekt w trakcie tworzenia# strona-z-grami

## Aktualizacja bazy danych
Repozytorium zostało rozszerzone o:
- pełny schemat bazy danych w `database/strona_z_grami.sql`,
- 8 przykładowych gier,
- użytkowników, kategorie, tagi, ulubione i oceny,
- prostą konfigurację połączenia w `backend/config/db.php`,
- API do pobierania gier i kategorii.

### Parametry API
`backend/api/games.php`
- `?q=snake` – wyszukiwanie
- `?category=logiczne` – filtrowanie po kategorii
- `?sort=newest|popular|rating|title` – sortowanie

