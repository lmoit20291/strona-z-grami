# Strona z grami

Próbujemy stworzyć platformę z grami przeglądarkowymi w stylu itch.io.

## Funkcje naszej strony
* **System gier**: Wyświetlamy listę gier prosto z bazy danych przez API (fetch + JSON). Gry można normalnie odpalać w przeglądarce (np. te eksportowane z Godota).
* **Użytkownicy**: Mamy gotową rejestrację, logowanie i obsługę sesji. Interfejs reaguje na to, czy ktoś jest zalogowany (przycisk zmienia się na "Wyloguj").
* **Baza danych**: Mamy pełną strukturę – od tabel użytkowników i gier, po kategorie, tagi, oceny i komentarze.
* **Hosting**: Projekt jest przygotowany pod deployment na 7m.pl.

## Technologie
* Frontend: HTML, CSS, JavaScript (Fetch API)
* Backend: PHP (sesje i logika)
* Baza: MySQL

## Struktura plików
* `frontend/` – strona wizualna
* `backend/` – cała logika i API
* `database/` – pliki bazy danych (.sql)
* `games/` – pliki gier

## Status projektu
Projekt jest w trakcie rozwoju. Mamy już gotowy system użytkowników, działające API i dynamiczny frontend połączony z bazą. W planach mamy jeszcze panel administratora, dodawanie gier przez stronę i dopracowanie wyglądu.

## Autorzy
Maksym Ratajczak, Igor Ratajczak, Kacper Strzyżewski, Dawid Zachaś