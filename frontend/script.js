let isRegister = false;

function toggleForm() {
  isRegister = !isRegister;

  document.getElementById('formTitle').textContent = isRegister ? 'Rejestracja' : 'Logowanie';
  document.getElementById('mainBtn').textContent = isRegister ? 'Zarejestruj' : 'Zaloguj';
  document.getElementById('registerExtra').style.display = isRegister ? 'block' : 'none';

  document.querySelector('.switch').textContent = isRegister
    ? 'Masz już konto? Zaloguj się'
    : 'Nie masz konta? Zarejestruj się';
}

function submitForm() {
  const email = document.getElementById('email').value;
  const password = document.getElementById('password').value;
  const msg = document.getElementById('msg');

  fetch('http://localhost/strona-z-grami/backend/login.php', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    },
    body: `email=${email}&password=${password}`
  })
  .then(res => res.text())
  .then(data => {
  if (data.trim() === "OK") {
    window.location.href = "index.html";
  } else {
    msg.textContent = data;
    msg.style.color = 'red';
  }
});
  
}

  if (window.location.pathname.includes("games.html")) {
  fetch('/strona-z-grami/backend/api/games.php')
    .then(res => res.json())
    .then(data => {
      const container = document.getElementById('games');

      data.forEach(game => {
        const div = document.createElement('div');
        div.classList.add('card');

        div.innerHTML = `
          <h3>${game.title}</h3>
          <button onclick="location.href='${game.game_url}'">Zagraj</button>
        `;

        container.appendChild(div);
      });
    });
}


document.addEventListener("DOMContentLoaded", () => {

  if (window.location.pathname.includes("games.html")) {
    fetch('http://localhost/strona-z-grami/backend/api/games.php')
      .then(res => res.json())
      .then(data => {
        const container = document.getElementById('games');

        if (!container) return;

        container.innerHTML = "";

        data.forEach(game => {
          const div = document.createElement('div');
          div.classList.add('card');

          div.innerHTML = `
            <h3>${game.title}</h3>
            <button onclick="location.href='${game.game_url}'">Zagraj</button>
          `;

          container.appendChild(div);
        });
      });
  }

});

fetch('http://localhost/strona-z-grami/backend/check_login.php')
  .then(res => res.text())
  .then(data => {
    const btn = document.getElementById('authBtn');
    const welcome = document.getElementById('welcomeText');

    if (data === "logged") {

      if (btn) {
        btn.textContent = "Wyloguj";

        btn.onclick = () => {
          fetch('http://localhost/strona-z-grami/backend/logout.php')
            .then(() => {
              window.location.href = "index.html";
            });
        };
      }

      // 🔥 pobieranie username
      fetch('http://localhost/strona-z-grami/backend/get_user.php')
        .then(res => res.text())
        .then(username => {
          if (welcome && username) {
            welcome.textContent = `Witaj ${username}`;
          }
        });

    } else {
      if (btn) {
        btn.textContent = "Logowanie";
        btn.href = "login.html";
      }
    }
  });