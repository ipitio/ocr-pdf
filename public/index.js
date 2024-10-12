(async () => {
    document.addEventListener("DOMContentLoaded", function () {
        fetch('README.md')
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                return response.text();
            })
            .then(text => {
                const contentDiv = document.getElementById('content');
                contentDiv.innerHTML = marked.parse(text);
                document.getElementById('loading').style.display = 'none';
                contentDiv.style.display = 'block';
                hljs.highlightAll();
            })
            .catch(error => {
                console.error('Error fetching README:', error);
                document.getElementById('loading').textContent = 'Failed to load README.md';
            });
    });
})();
