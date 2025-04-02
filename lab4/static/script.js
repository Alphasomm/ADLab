async function sendQuery() {
    try {
        const chatBox = document.getElementById('chat-box');
        const input = document.getElementById('user-input');
        
        // Add temporary loading indicator
        chatBox.innerHTML += `<div class="message bot-message">Processing...</div>`;
        
        const response = await fetch('/query', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ 
                query: input.value,
                model: document.getElementById('model-select').value
            })
        });
        
        if (!response.ok) {
            const error = await response.json();
            throw new Error(error.error || 'Unknown error');
        }
        
        const data = await response.json();
        // Replace loading indicator with actual response
        chatBox.lastElementChild.textContent = data.response;
        
    } catch (error) {
        chatBox.lastElementChild.textContent = `Error: ${error.message}`;
        console.error('Query error:', error);
    }
}