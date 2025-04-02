# Add these imports at the top
import logging
from pprint import pformat

# Configure logging
logging.basicConfig(level=logging.DEBUG)

@app.route('/upload', methods=['POST'])
def upload_file():
    try:
        # Add debug logs
        logging.debug(f"Received file: {file.filename}")
        logging.debug(f"File size: {os.path.getsize(file_path)} bytes")
        
        chunks = process_document(file_path, file_extension)
        logging.debug(f"Processing complete. Chunks: {len(chunks)}")
        logging.debug(f"First chunk: {chunks[0].page_content[:100]}...")

        embeddings = OllamaEmbeddings(model="llama2")
        vector_store = FAISS.from_documents(chunks, embeddings)
        logging.debug("Vector store created successfully")
        
    except Exception as e:
        logging.error(f"Upload error: {str(e)}", exc_info=True)
        return jsonify({'error': str(e)}), 500

@app.route('/query', methods=['POST'])
def handle_query():
    global vector_store, current_model
    data = request.json
    query = data.get('query')
    current_model = data.get('model', 'llama2')
    
    if not vector_store:
        return jsonify({'error': 'No document processed yet'}), 400
    
    try:
        # Step 1: Retrieve relevant context
        docs = vector_store.similarity_search(query, k=3)
        context = "\n".join([doc.page_content for doc in docs])

        # ======== ADD THIS MODIFIED PROMPT TEMPLATE ========
        prompt = f"""Answer this question based ONLY on the provided context:
        Context: {context}

        Question: {query}
        If the answer isn't in the context, say "I don't know".

        Answer: """
        # ======== END OF MODIFIED SECTION ========

        # Step 2: Generate response
        response = ollama.generate(
            model=current_model,
            prompt=prompt,
            stream=False
        )
        
        return jsonify({'response': response['response']})
    except Exception as e:
        return jsonify({'error': str(e)}), 500