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

    if (!email || !password || !username) {
      msg.textContent = 'Wypełnij wszystkie pola';
      msg.style.color = 'red';
      return;
    }

    msg.textContent = 'Konto utworzone!';
    msg.style.color = 'lightgreen';
  } else {
    if (email === 'admin' && password === '1234') {
      msg.textContent = 'Zalogowano!';
      msg.style.color = 'lightgreen';
    } else {
      msg.textContent = 'Błędne dane';
      msg.style.color = 'red';
    }
  }
}

fetch('http://localhost/strona-z-grami/backend/api/games.php')
  .then(res => res.json())
  .then(data => {
    console.log(data);
  });