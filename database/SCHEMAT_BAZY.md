# Schemat bazy danych – Strona z grami

## Co obejmuje baza
Baza została przygotowana pod wymagania projektu:
- minimum 8 gier,
- kategorie i tagi,
- wyszukiwanie, filtrowanie i sortowanie,
- rejestracja/logowanie użytkowników,
- ulubione,
- oceny i komentarze,
- panel administratora z CRUD dla gier i kategorii.

## Tabele
- `users` – użytkownicy i administratorzy
- `categories` – kategorie gier
- `games` – główna tabela gier
- `tags` – słownik tagów
- `game_tags` – relacja wiele-do-wielu gry ↔ tagi
- `favorites` – ulubione gry użytkowników
- `reviews` – oceny i komentarze
- `v_games_catalog` – widok do wygodnego pobierania katalogu gier

## Konta testowe
- administrator:
  - login: `admin@stronazgrami.local`
  - hasło: `admin123`
- użytkownik:
  - login: `gracz1@stronazgrami.local`
  - hasło: `user1234`

## Jak zaimportować bazę
1. Uruchom XAMPP: Apache + MySQL.
2. Wejdź do phpMyAdmin.
3. Importuj plik `database/strona_z_grami.sql`.
4. Baza utworzy się sama jako `strona_z_grami`.

## Uwagi projektowe
- `games.created_at` służy do sortowania po najnowszych.
- `games.play_count` służy do sortowania po popularności.
- Walidacja oceny 1–5 oraz wymóg „ocena lub komentarz” są pilnowane triggerami.
- Ochrona panelu admina może opierać się na polu `users.role`.
