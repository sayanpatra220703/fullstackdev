const form = document.getElementById('todoForm');
const input = document.getElementById('taskInput');
const list = document.getElementById('todoList');
const countEl = document.getElementById('count');
const clearCompletedBtn = document.getElementById('clearCompleted');
const clearAllBtn = document.getElementById('clearAll');

let todos = JSON.parse(localStorage.getItem('todos') || '[]');

function save(){ localStorage.setItem('todos', JSON.stringify(todos)); }

function render(){
  list.innerHTML = '';
  todos.forEach((t, i) => {
    const li = document.createElement('li');
    li.className = 'item';

    const left = document.createElement('div'); left.className='left';
    const cb = document.createElement('button');
    cb.className = 'checkbox' + (t.done ? ' checked' : '');
    cb.setAttribute('aria-pressed', String(!!t.done));
    cb.title = t.done ? 'Mark as not done' : 'Mark as done';
    cb.addEventListener('click', ()=>{ todos[i].done = !todos[i].done; save(); render(); });
    cb.innerHTML = t.done ? '✓' : '';

    const txt = document.createElement('div');
    txt.className = 'task' + (t.done ? ' completed' : '');
    txt.textContent = t.text;

    left.appendChild(cb); left.appendChild(txt);

    const actions = document.createElement('div'); actions.className='actions';
    const del = document.createElement('button'); del.className='btn del'; del.textContent='Delete';
    del.addEventListener('click', ()=>{ todos.splice(i,1); save(); render(); });
    actions.appendChild(del);

    li.appendChild(left); li.appendChild(actions);
    list.appendChild(li);
  });

  const remaining = todos.filter(t=>!t.done).length;
  countEl.textContent = remaining + (remaining===1? ' task ' : ' tasks ') + 'left';
}

form.addEventListener('submit', e=>{
  e.preventDefault();
  const value = input.value.trim();
  if(!value) return;
  todos.push({text:value, done:false, id:Date.now()});
  input.value=''; save(); render();
});

clearCompletedBtn.addEventListener('click', ()=>{
  todos = todos.filter(t=>!t.done); save(); render();
});
clearAllBtn.addEventListener('click', ()=>{
  if(!confirm('Clear all tasks?')) return;
  todos = []; save(); render();
});

render();
