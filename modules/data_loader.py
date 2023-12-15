import pandas as pd
from sklearn.impute import SimpleImputer
from sklearn.preprocessing import OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline

def load_data(filepath):
    df = pd.read_parquet("dataset\housing.parquet")
    
    categorical_cols = ['type', 'laundry_options', 'parking_options', 'state']  # ajuste conforme necessário

    
    numeric_imputer = SimpleImputer(strategy='mean')

    
    categorical_transformer = Pipeline(steps=[
        ('imputer', SimpleImputer(strategy='most_frequent')),
        ('onehot', OneHotEncoder(handle_unknown='ignore', sparse=False))
    ])

    
    preprocessor = ColumnTransformer(
        transformers=[
            ('num', numeric_imputer, ['lat', 'long', 'price', 'sqfeet', 'beds', 'baths', 'cats_allowed', 'dogs_allowed', 'smoking_allowed', 'wheelchair_access', 'electric_vehicle_charge', 'comes_furnished']),
            ('cat', categorical_transformer, categorical_cols)
        ])

    
    df_transformed = preprocessor.fit_transform(df)

    
    columns = (['lat', 'long', 'price', 'sqfeet', 'beds', 'baths', 'cats_allowed', 'dogs_allowed', 'smoking_allowed', 'wheelchair_access', 'electric_vehicle_charge', 'comes_furnished'] + 
               preprocessor.named_transformers_['cat']['onehot'].get_feature_names_out(categorical_cols).tolist())

    
    df_transformed = pd.DataFrame(df_transformed, columns=columns)

    return df_transformed