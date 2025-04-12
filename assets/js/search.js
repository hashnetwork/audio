let posts = [];

fetch('/search.json')
  .then(res => res.json())
  .then(data => posts = data);

function performSearch() {
  const query = document.getElementById('search-box').value.toLowerCase();
  const resultsContainer = document.getElementById('results');
  resultsContainer.innerHTML = '';

  const results = posts.filter(post => 
    post.title.toLowerCase().includes(query) || 
    post.content.toLowerCase().includes(query)
  );

  if (results.length === 0) {
    resultsContainer.innerHTML = '<p>No results found.</p>';
    return;
  }

  const list = document.createElement('ul');
  results.forEach(post => {
    const item = document.createElement('li');
    item.innerHTML = `<a href="${post.url}">${post.title}</a>`;
    list.appendChild(item);
  });
  resultsContainer.appendChild(list);
}
