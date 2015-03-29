#cd Documents/Woolies/
import pandas as pd
import numpy as np
import datetime
import matplotlib.pyplot as plt
import time

parse = lambda x: pd.datetime.strptime(x, '%d/%m/%y')

data=pd.read_csv('train2.csv',index_col='date',parse_dates='date',date_parser=parse)
store_prod=raw_input('Store_product_number: ')
data[data.product_store_id==store_prod]['sales'].plot(label=store_prod)
plt.show()

#data['t']=time.mktime(data.index.timetuple())
a=np.fft.fft(data[data.product_store_id==store_prod]['sales'])
