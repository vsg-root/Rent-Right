import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import missingno as msno
import plotly.express as px
import xgboost as xgb
from xgboost import plot_importance


st.set_page_config(
    page_title = 'Dashboard Rent Right',
    layout = 'wide',
    menu_items = {
        'About': '''Esse projeto foi desenvolvido pelos alunos Alexandre, Heitor, Pedro, Vinivius Ferraz, Vinicius Santos e Vinicius Gomes.'''
    }
)

st.markdown(f'''
    <h1>PSI3</h1>
    <h2>RentRight: Optimizing Rental Predictions through Machine Learning</h2>
''', unsafe_allow_html=True)


header = st.container()


    
image = st.image('assets\Logo_Rent_new_Git.png', width= 700)
st.text('Presented by Ferraz, Alexandre, Gomes, Santos, Pedro, Heitor ')


st.markdown('''# Data Analysis and Machine Learning Report

**Date of Report:** [Insert report date]

## Executive Summary

This report presents a comprehensive analysis of the "USA Housing Listings" dataset, which contains detailed information about property listings for sale in the United States. The objective of this analysis is to gain insights into the real estate market in the USA, including property types, pricing, amenities, and geographical locations. Additionally, this dataset serves as the foundation for the development of machine learning models for predictive analysis.

### Dataset Overview

- **Number of Records:** [Insert number of records]
- **Data Collection Period:** The dataset is updated periodically.
- **Available Information:** The dataset encompasses data such as property prices, types, square footage, bedrooms, bathrooms, and various amenities like pet allowances, wheelchair accessibility, and more.

This report not only delves into exploratory data analysis but also highlights the application of machine learning models for predictive purposes, including price prediction and property type classification.

## Introduction

The "USA Housing Listings" dataset, sourced from Craigslist, is a rich repository of information essential for a holistic understanding of the real estate landscape in the United States. Beyond providing valuable insights, it serves as the basis for the development of machine learning models, adding a predictive dimension to the analysis.

[Include any specific objectives, goals, or additional context here.]

## Exploratory Data Analysis

[Insert sections for EDA, data cleaning, visualizations, and insights.]

## Machine Learning Models

[Detail the machine learning models being employed, their objectives, and methodologies.]

## Conclusion

[Summarize key findings, insights, and any future directions.]

## Property Listings Table

For reference, the following table describes the columns within the "USA Housing Listings" dataset:


| Column Name               | Description                                       |
|---------------------------|---------------------------------------------------|
| id                        | Unique identifier for each listing.              |
| url                       | Listing URL for more details.                   |
| region                    | Geographical region or city where the property is located. |
| region_url                | URL of the region where the property is located. |
| price                     | Property sale price.                             |
| type                      | Property type (house, apartment, etc.).         |
| sqfeet                    | Property square footage in square feet.         |
| beds                      | Number of bedrooms in the property.             |
| baths                     | Number of bathrooms in the property.            |
| cats_allowed              | Indication if cats are allowed (1 for allowed, 0 for not allowed). |
| dogs_allowed              | Indication if dogs are allowed (1 for allowed, 0 for not allowed). |
| smoking_allowed           | Indication if smoking is allowed (1 for allowed, 0 for not allowed). |
| wheelchair_access         | Indication if the property is wheelchair accessible (1 for accessible, 0 for not accessible). |
| electric_vehicle_charge   | Indication if the property offers electric vehicle charging (1 for available, 0 for not available). |
| comes_furnished           | Indication if the property is furnished (1 for furnished, 0 for unfurnished). |
| laundry_options           | Laundry facilities available on the property (e.g., on-site, in-unit, etc.). |
| parking_options           | Parking options available on the property (e.g., garage, street, etc.). |
| image_url                 | URL of an image of the property.                |
| description               | Description of the property provided in the listing. |
| lat                       | Latitude of the property's location.             |
| long                      | Longitude of the property's location.            |
| state                     | State in which the property is located.        |

''')   
    
st.markdown('''## Viewing dataset columns''')
dataset = pd.read_parquet("C:\Dev\Rent-Right\dataset\housing.parquet")
st.write(dataset.head())

del_columns = ['laundry_options', 'parking_options', 'id', 'url', 'image_url', 'region_url', 'description']
dataset = dataset.drop(del_columns, axis=1)

dataset = dataset.dropna()

st.markdown('''## Viewing datasete columns after cleaning''')
analysis_df = dataset.copy()
st.write(analysis_df.head())

# boxplot
analysis_df = analysis_df[(analysis_df["price"] >= 340) & (analysis_df["price"] <= 3395)]
st.title("Boxplot for Identification of Outliers")
fig, ax = plt.subplots(figsize=(6, 4))
ax.boxplot(analysis_df["price"])
ax.set_title("Boxplot for Identification of Outliers")
st.pyplot(fig)


st.title('Histogram of numeric columns')
numeric_columns = analysis_df.select_dtypes(include=['number'])

# Para cada coluna numérica, crie e exiba um histograma
for column in numeric_columns.columns:
    st.subheader(f" Histogram of {column}")
    fig = px.histogram(analysis_df, x=column)
    fig.update_xaxes(title_text=column)
    fig.update_yaxes(title_text='Frequency')
    st.plotly_chart(fig)



