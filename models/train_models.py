import pandas as pd
from sklearn.metrics import mean_absolute_error
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.externals import joblib
from sklearn.ensemble import GradientBoostingRegressor, RandomForestRegressor
from sklearn.linear_model import LinearRegression
from sklearn.tree import DecisionTreeRegressor
from sklearn.neighbors import KNeighborsRegressor
from sklearn.neural_network import MLPRegressor


class RegressionModelTrainer:
    def __init__(self, model):
        self.model = model

    def train(self, X_train, y_train):
        self.model.fit(X_train, y_train)

    def predict(self, X_test):
        return self.model.predict(X_test)

    def evaluate(self, y_true, y_pred):
        return mean_absolute_error(y_true, y_pred)

    def save_model(self, filename):
        joblib.dump(self.model, filename)


class ModelTrainer:
    def __init__(self, models):
        self.models = models

    def train_models(self, X_train, y_train):
        trained_models = {}
        for name, model in self.models.items():
            model_trainer = RegressionModelTrainer(model)
            model_trainer.train(X_train, y_train)
            trained_models[name] = model_trainer
        return trained_models

    def evaluate_models(self, trained_models, X_test, y_test):
        for name, model_trainer in trained_models.items():
            y_pred = model_trainer.predict(X_test)
            mae = model_trainer.evaluate(y_test, y_pred)
            print(f"Model: {name}")
            print("Mean Absolute Error:", mae)
            model_trainer.save_model(f'{name.lower().replace(" ", "_")}_model.pkl')


models = {
    "Linear Regression": LinearRegression(),
    "Gradient Boosting": GradientBoostingRegressor(),
    "Random Forest": RandomForestRegressor(),
    "Decision Tree": DecisionTreeRegressor(),
    "KNeighborsRegressor": KNeighborsRegressor(),
    "MLP Regressor": MLPRegressor()
}

analysis_df = pd.read_csv("model_input_data.csv")
X = analysis_df.drop('price', axis=1)
y = analysis_df['price']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

trainer = ModelTrainer(models)
trained_models = trainer.train_models(X_train, y_train)
trainer.evaluate_models(trained_models, X_test, y_test)
