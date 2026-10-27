import pandas as pd
import numpy as np

df = pd.read_csv("Raw_3000.csv")

#data inspection
# print(df.head())
# print(df.shape)
# print(df.info())
# print(df.describe())

# Data cleaning
# print(df.isnull().sum())

#check duplicates
# print(df.duplicated().sum())

#check unique values
# print(df["Category"].unique())
# print(df["Region"].unique())
# print(df["Payment_Mode"].unique())

#convrt date
# df["Order_Date"] = pd.to_datetime(df["Order_Date"],format='%d-%m-%Y')
# print(df['Order_Date'].dtype)

#Exploratory data analysis

#Calculate Profit margin
# df['Profit_margin_percentage']= (df['Profit']/df['Sales']) *100

#Analyze Category counts
# print("-- Order Distribution by category")
# category_counts = df["Category"].value_counts()
# print(category_counts)
# print("\n")
# 
# Analyze category --> Sales, Profit and Profit margin
# print("-- Financial Metrics by Category --")
# category_analysis = df.groupby("Category").agg(
    # Total_Sales = ('Sales', 'sum',),
    # Total_Profit = ('Profit','sum'),
    # Average_Profit_Margin = ('Profit_Margin','mean')
# ).sort_values(by='Total_Sales', ascending = False)
# 
# pd.options.display.float_format= '{:,.2f}'.format
# print(category_analysis)


#Analyze Sales by Region --> Sales,Profit,Profit_margin
# 
# print('-- Financial metrics by Region')
# Region_analysis= (df.groupby("Region").agg(
    # Total_sales=('Sales','sum'),
    # Total_Profit=('Profit','sum'),
    # Average_Profit_Margin=("Profit_Margin","mean")
# ).sort_values(by='Total_sales',ascending = False))
# 
# print(Region_analysis)
# 
# print("-- Financial metrics by Product--")
# Product_analysis = (df.groupby("Product").agg(
    # Total_sales=("Sales", "sum"),
    # Total_profit=("Profit","sum")
# ).sort_values(by = "Total_sales", ascending = False))
# 
# print(Product_analysis)
# 
# print("--Financial metrics of a Customer--")
# 
# Report_analysis = (df.groupby("Customer_ID").agg(
    # Total_sales = ("Sales","sum"),
    # Total_orders = ("Order_ID","count")
# ).sort_values(by= "Total_sales", ascending = False))
# 
# print(Report_analysis)
# 
import matplotlib.pyplot as plt
# 
# print("-- Monthly SAles by line chart--")
# df['Order_Date']=pd.to_datetime(df["Order_Date"], format='%d-%m-%y')
# 
# monthly_sales = df.groupby(
    # df["Order_Date"].dt.to_period("M")
# )["Sales"].sum()
# 
# monthly_sales.plot(
    # kind = 'line',
    # figsize = (10,5),
    # color = 'steelblue',
    # title = 'Monthly Sales'
# )
# 
# plt.xlabel("Month")
# plt.ylabel("Total Sales")
# plt.tight_layout()
# plt.show()

# print("-- Category sales by chart--")
# 
# category_sales = df.groupby("Category")["Sales"].sum()
# 
# category_sales.plot(
    # kind ='bar',
    # color = "steelblue",
    # edgecolor = "black"
# )
# 
# plt.title("Category-wise Sales")
# plt.xlabel("Category")
# plt.ylabel("Total Sales")
# plt.xticks(rotation = 45)
# plt.tight_layout()
# 
# plt.show()

# print("-- Regional sales chart--")
# 
# regional_sales = df.groupby("Region")["Sales"].sum()
# 
# fig, ax= plt.subplots(figsize = (9,5))
# 
# bars = ax.bar(
    # regional_sales.index,
    # regional_sales.values,
    # color = ["skyblue","orange","green","coral","purple"],
    # edgecolor = "black"
# )
# 
# ax.bar_label(bars, fmt="%.0f", padding = 3)
# 
# ax.set_title("Regional Sales Performance", fontsize = 16, fontweight = "bold")
# ax.set_xlabel("Region", fontsize =12)
# ax.set_ylabel("Total Sales", fontsize = 12)
# 
# ax.grid(axis='y', linestyle = '--',alpha =0.5)
# ax.set_axisbelow(True)
# 
# plt.tight_layout
# 
# plt.savefig("regionl_sales.png", dpi = 300, bbox_inches = "tight")
# plt.show()
# 
# print("-- Top 10 products--")
# 
# top_10= (df.groupby("Product",as_index=False)["Sales"].sum()
# .nlargest(10,"Sales")
# )

# pd.options.display.float_format='{:,.2f}'.format
# print(top_10_products.to_string(index =False))

# plt.figure(figsize = (10,6))
# plt.barh(top_10["Product"],top_10["Sales"],color = 'skyblue')
# 
# plt.title("Top 10 products by Sales",fontsize=16)
# plt.xlabel("Total Sales")
# plt.ylabel("Product")
# 
# for index, value in enumerate(top_10["Sales"]):
    # plt.text(value,index,f"{value:,}",va="center")
# 
# plt.tight_layout()
# plt.show()

import seaborn as sns

# print("--Profit Distribution histogram/boxplot")
# plt.figure(figsize=(8,4))
# sns.boxplot(x=df["Profit"],color="lightgreen")
# 
# plt.title("Boxplot of profit")
# plt.xlabel("Profit")
# plt.tight_layout()
# plt.show()


# print("-- Discount vs Profit margin  scatter plot--")
# sns.scatterplot(
    # data=df,
    # x="Discount",
    # y="Profit_Margin"
# )
# 
# plt.title("Discount vs Profit Margin")
# plt.show()

# print("-- Customer Analysis using Pyhton--")
# 
# Total_customers = df["Customer_ID"].nunique()
# print("Total customers =  ", Total_customers)
# 
# Average_customer_revenue= df["Sales"].sum()/df["Customer_ID"].nunique()
# print("Average Customer Revenue:  ", Average_customer_revenue)
# 
# Top_10_customers = (
    # df.groupby("Customer_ID", as_index= False)["Sales"]
    # .sum()
    # .nlargest(10,"Sales")
    # .sort_values(by = "Sales",ascending=True)
# )
# print("Top 10 customers:  ", Top_10_customers.sort_values("Sales",ascending=False))
# 
# print("-- Repeat Customers--")
# Repeat_customers=(df.groupby("Customer_ID")["Order_ID"]
#  .nunique()
# .reset_index(name="Number of orders")                               )
# 
# Repeat_customers= Repeat_customers[Repeat_customers["Number of orders"]>1
# ]
# print(Repeat_customers)
# 
# print("--One time customers--")
# One_time_customers =(df.groupby("Customer_ID")["Order_ID"]
# .nunique()
# .reset_index(name="number of orders")
# )
# 
# One_time_customers = One_time_customers[One_time_customers["number of orders"]==1]
# print(One_time_customers)
# 
# print("--Customer Segments--")
# Customer_segments=(df.groupby("Customer_ID", as_index=False).agg(
    # Total_Sales = ("Sales", "sum"),
    # Number_of_Orders = ("Order_ID", "nunique")
    # )
# )
# print(Customer_segments.head())
# 
# Customer_segments["Customer_Segment"] = np.select(
    # [
        # (Customer_segments["Total_Sales"] >=40000)&
        # (Customer_segments["Number_of_Orders"] >1),
        # Customer_segments["Number_of_Orders"] >1,
        # Customer_segments["Number_of_Orders"]==1
    # ],
    # [
        # "High-Value Customer",
        # "Repeat Customers",
        # "One-Time Customers"
    # ],
    # default="Other Customers"
# 
# )
# print(Customer_segments)
# 
# print(Customer_segments['Customer_Segment'].value_counts())
# 
# print(Customer_segments['Customer_Segment'].value_counts(normalize=True).mul(100).round(2))
# 

print("--Create a Customer-level Data Frame--")

Customer_df = (
    df.groupby("Customer_ID",as_index=False)
    .agg(
       Total_orders=("Order_ID","nunique"),
       Total_sales=("Sales","sum"),
       Total_profit=("Profit","sum")
    )
    )

Customer_df["Average_Order_Value"]=(
    Customer_df["Total_sales"]/Customer_df["Total_orders"]
)

conditions=[
    (Customer_df["Total_sales"]>=40000)&
    (Customer_df["Total_orders"] >1),
    (Customer_df["Total_orders"]>1),
    (Customer_df["Total_orders"]==1)
]
segments = [
    "High-Value Customer",
    "Repeat Customer",
    "One-Time Customer"
]

Customer_df["Customer_Segment"]=np.select(
    conditions,
    segments,
    default="Other Customer"
)

Customer_df=Customer_df[
    [
        "Customer_ID",
        "Total_orders",
        "Total_sales",
        "Total_profit",
        "Average_Order_Value",
        "Customer_Segment"
    ]
]

print(Customer_df.head(10))

print("--Statistical Analysis--")

Average_Order_Value = df["Sales"].sum()/df["Order_ID"].nunique()

print("Average_Order_Value = " ,Average_Order_Value)


Returned_rate=(
    (df["Order_Status"] == "Returned").sum()
/len(df)
)*100

print("Return Percentage: ", round(Returned_rate,2),"%")

Cancellation_rate=(
    (df["Order_Status"] == "Cancelled").sum()
/len(df)
)*100

print("Cancellation Percentage: ", round(
Cancellation_rate,2),"%")

Profit_Margin=( df["Profit"].sum()/df["Sales"].sum())*100
print(Profit_Margin, "%")