from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/predict_lr', methods=['POST'])
def predict_lr():
    data = request.get_json(force=True)
    prediction = lr_model.predict(np.array([[data['day']]]))
    return jsonify({'prediction': prediction[0]})

@app.route('/predict_lstm', methods=['POST'])
def predict_lstm():
    data = request.get_json(force=True)
    # Prepare input for LSTM
    input_data = np.array([data['data']])
    input_data = scaler.transform(input_data)
    input_data = input_data.reshape(1, input_data.shape[0], 1)
    prediction = lstm_model.keras.predict(input_data)
    prediction = scaler.inverse_transform(prediction)
    return jsonify({'prediction': prediction[0][0]})

if __name__ == '__main__':
    app.run(debug=True)