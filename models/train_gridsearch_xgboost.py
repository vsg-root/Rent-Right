import pandas as pd
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.preprocessing import StandardScaler
from xgboost import XGBRegressor
from sklearn.metrics import mean_absolute_error
import joblib

class XGBRegressorTrainer:
    def __init__(self, data_file):
        self.data = pd.read_csv(data_file)

    def preprocess_data(self):
        X = self.data.drop('price', axis=1)
        y = self.data['price']
        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
        scaler = StandardScaler()
        X_train = scaler.fit_transform(X_train)
        X_test = scaler.transform(X_test)
        return X_train, X_test, y_train, y_test

    def train_model(self, X_train, y_train):
        param_grid = {
            'learning_rate': [0.01, 0.1, 0.2],
            'n_estimators': [50, 100, 200],
            'max_depth': [3, 5, 7],
        }
        xgb_model = XGBRegressor()
        grid_search = GridSearchCV(estimator=xgb_model, param_grid=param_grid, scoring='neg_mean_absolute_error', cv=3, verbose=2, n_jobs=-1)
        grid_search.fit(X_train, y_train)
        return grid_search

    def evaluate_model(self, model, X_test, y_test):
        y_pred = model.predict(X_test)
        mae = mean_absolute_error(y_test, y_pred)
        print("Mean Absolute Error:", mae)

    def save_model(self, model, filename):
        joblib.dump(model, filename)

xgb_trainer = XGBRegressorTrainer('model_input_data.csv')
X_train, X_test, y_train, y_test = xgb_trainer.preprocess_data()
xgb_model = xgb_trainer.train_model(X_train, y_train)
print("Best Parameters:", xgb_model.best_params_)
xgb_trainer.evaluate_model(xgb_model.best_estimator_, X_test, y_test)
xgb_trainer.save_model(xgb_model.best_estimator_, 'tuned_xgb_model.pkl')
