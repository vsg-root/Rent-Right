import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import mean_absolute_error
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout
from tensorflow.keras.optimizers import Adam


class NeuralNetworkTrainer:
    def __init__(self, input_shape):
        self.model = self.build_model(input_shape)

    def build_model(self, input_shape):
        model = Sequential()
        model.add(Dense(128, activation='relu', input_shape=input_shape))
        model.add(Dropout(0.5))
        model.add(Dense(64, activation='relu'))
        model.add(Dropout(0.5))
        model.add(Dense(32, activation='relu'))
        model.add(Dropout(0.3))
        model.add(Dense(16, activation='relu'))
        model.add(Dense(1, activation='linear'))
        return model

    def compile_model(self, optimizer='adam', loss='mean_absolute_error', metrics=['mae']):
        self.model.compile(optimizer=optimizer, loss=loss, metrics=metrics)

    def train_model(self, X_train, y_train, epochs=100, batch_size=32, validation_data=None, verbose=1):
        return self.model.fit(X_train, y_train, epochs=epochs, batch_size=batch_size, validation_data=validation_data, verbose=verbose)

    def evaluate_model(self, X_test, y_test):
        return self.model.evaluate(X_test, y_test)

    def predict(self, X_test):
        return self.model.predict(X_test)


analysis_df = pd.read_csv("model_input_data.csv")
X = analysis_df.drop('price', axis=1)
y = analysis_df['price']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

nn_trainer = NeuralNetworkTrainer(input_shape=(X_train.shape[1],))
nn_trainer.compile_model(optimizer=Adam(learning_rate=0.001), loss='mean_absolute_error', metrics=['mae'])
nn_trainer.train_model(X_train, y_train, epochs=100, batch_size=32, validation_data=(X_test, y_test), verbose=2)

loss, mae = nn_trainer.evaluate_model(X_test, y_test)
print("Mean Absolute Error:", mae)

y_pred_nn = nn_trainer.predict(X_test)
