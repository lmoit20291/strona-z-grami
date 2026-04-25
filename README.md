# 🎮 Strona z grami

Projekt szkolny polegający na stworzeniu platformy z grami przeglądarkowymi, podobnej do itch.io.

---

## 🚀 Funkcje (aktualnie)

- wyświetlanie listy gier z bazy danych
- uruchamianie gier w przeglądarce (np. eksport z Godot)
- rejestracja użytkowników
- logowanie i sesje użytkownika
- wylogowywanie
- dynamiczna zmiana przycisku „Logowanie” → „Wyloguj”
- wyświetlanie gier z API (fetch + JSON)
- integracja frontend ↔ backend ↔ baza danych

---

## 🛠 Technologie

- HTML
- CSS
- JavaScript (fetch API)
- PHP (backend + sesje)
- MySQL (baza danych)

---

## 📂 Struktura projektu

### Lokalnie (XAMPP)
/strona-z-grami/
├── frontend/
├── backend/
├── database/
├── games/

### Produkcja (7m.pl)
/public_html/
├── index.html
├── games.html
├── login.html
├── style.css
├── script.js
├── /games/
├── /backend/

---

## ▶️ Jak uruchomić (lokalnie)

1. Pobierz repozytorium  
2. Uruchom XAMPP (Apache + MySQL)  
3. Wgraj projekt do: htdocs/strona-z-grami
4. Zaimportuj bazę:
- phpMyAdmin → import `database/strona_z_grami.sql`
5. Otwórz: http://localhost/strona-z-grami/frontend/

---

## 🌐 Deployment (7m.pl)

Aby strona działała poprawnie:
- wszystkie pliki muszą być w `/public_html/`
- ścieżki w JS muszą być absolutne, np.: ```js fetch('/backend/api/games.php')
- gry muszą znajdować się w: /public_html/games/

---

## 🗄 Baza danych

Projekt zawiera:

    użytkowników (logowanie/rejestracja)

    gry (min. 8)

    kategorie

    tagi

    ulubione

    oceny i komentarze

API: backend/api/games.php

Parametry:

    ?q=snake – wyszukiwanie

    ?category=logiczne – filtrowanie po kategorii

    ?sort=newest|popular|rating|title – sortowanie

---

## 👥 Autorzy

    Maksym Ratajczak

    Igor Ratajczak

    Kacper Strzyżewski

    Dawid Zachaś

---

## 📌 Status

🟡 Projekt w trakcie rozwoju

Aktualnie działa:

    system użytkowników

    API gier

    frontend z dynamicznym ładowaniem

    integracja z hostingiem (7m.pl)

Planowane:

    panel admina

    dodawanie gier przez UI

    ulepszony design

---




