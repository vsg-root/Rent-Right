import pandas as pd
from sklearn.preprocessing import LabelEncoder

class DataPreprocessor:
    def __init__(self, input_file, output_file):
        self.input_file = input_file
        self.output_file = output_file

    def load_data(self):
        return pd.read_csv(self.input_file)

    def remove_columns(self, dataset):
        del_columns = ['laundry_options', 'parking_options', 'id', 'url', 'image_url', 'region_url', 'description']
        return dataset.drop(del_columns, axis=1)

    def preprocess_data(self, dataset):
        dataset = dataset.dropna()

        for col_name in dataset.select_dtypes(include='object').columns:
            label_encoder = LabelEncoder()
            dataset[col_name] = label_encoder.fit_transform(dataset[col_name])

        dataset = dataset[(dataset["price"] >= 340) & (dataset["price"] <= 3395)]

        return dataset

    def save_data(self, dataset):
        dataset.to_csv(self.output_file, index=False)

    def process_data(self):
        dataset = self.load_data()

        dataset = self.remove_columns(dataset)

        dataset = self.preprocess_data(dataset)

        self.save_data(dataset)

preprocessor = DataPreprocessor('housing.csv', 'model_input_data.csv')
preprocessor.process_data()
