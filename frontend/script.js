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

    if (isRegister) {
    const username = document.getElementById('username').value;

    fetch('/strona-z-grami/backend/register.php', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: `username=${username}&email=${email}&password=${password}`
    })
    .then(res => res.text())
    .then(data => {
      msg.textContent = data;
    });

  } else {
  

  fetch('/strona-z-grami/backend/login.php', {
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
}

document.addEventListener("DOMContentLoaded", () => {

  if (window.location.pathname.includes("games.html")) {
    fetch('/strona-z-grami/backend/api/games.php')
      .then(res => res.json())
      .then(data => {
        const container = document.getElementById('games');

        if (!container) return;

        container.innerHTML = "";

        data.forEach(game => {
          const div = document.createElement('div');
          div.classList.add('card');

          const img = game.thumbnail ? game.thumbnail : 'default.jpg';

          div.innerHTML = `
            <div class="card-bg" style="background-image: url('${img}')"></div>
            <div class="card-content">
              <h3>${game.title}</h3>
              <button onclick="location.href='/strona-z-grami${game.game_url}'">Zagraj</button>
            </div>
          `;

          container.appendChild(div);
          
        });
      });
  }

});

fetch('/strona-z-grami/backend/check_login.php')
  .then(res => res.text())
  .then(data => {
    const btn = document.getElementById('authBtn');
    const welcome = document.getElementById('welcomeText');

    if (data === "logged") {

      if (btn) {
        btn.textContent = "Wyloguj";

        btn.onclick = () => {
          fetch('/strona-z-grami/backend/logout.php')
            .then(() => {
              window.location.href = "/strona-z-grami/frontend/index.html";
            });
        };
      }

      // pobieranie username
      fetch('/strona-z-grami/backend/get_user.php')
        .then(res => res.text())
        .then(username => {
          if (welcome && username) {
            welcome.textContent = `${username}`;
          }
        });

    } else {
      if (btn) {
        btn.textContent = "Logowanie";
        btn.href = "/strona-z-grami/frontend/login.html";
      }
    }
  });