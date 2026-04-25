# Strona z grami

Projekt szkolny – robimy platformę z grami przeglądarkowymi w stylu itch.io.

## Co już działa
* **System gier**: Wyświetlamy listę gier prosto z bazy danych przez API (fetch + JSON). Gry można normalnie odpalać w przeglądarce (np. te eksportowane z Godota).
* **Użytkownicy**: Mamy gotową rejestrację, logowanie i obsługę sesji. Interfejs reaguje na to, czy ktoś jest zalogowany (przycisk zmienia się na "Wyloguj").
* **Baza danych**: Mamy pełną strukturę – od tabel użytkowników i gier (na start wrzucone min. 8 sztuk), po kategorie, tagi, oceny i komentarze.
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

## Jak to odpalić u siebie (XAMPP)
1. Wrzuć folder projektu do `htdocs/strona-z-grami`.
2. Odpal Apache i MySQL w XAMPPie.
3. Wejdź w phpMyAdmin i zaimportuj plik `database/strona_z_grami.sql`.
4. Strona powinna śmigać pod adresem: `http://localhost/strona-z-grami/frontend/

## API i parametry
Gry z backendu pobieramy przez `backend/api/games.php`. 
Można używać parametrów:
* `?q=nazwa` – szukanie konkretnej gry
* `?category=nazwa` – filtrowanie po kategorii
* `?sort=newest|popular|rating|title` – sortowanie wyników

## Status projektu
Projekt jest w trakcie rozwoju. Mamy już gotowy system użytkowników, działające API i dynamiczny frontend połączony z bazą. W planach mamy jeszcze panel administratora, dodawanie gier przez stronę i dopracowanie wyglądu.

## Autorzy
Maksym Ratajczak, Igor Ratajczak, Kacper Strzyżewski, Dawid Zachaś