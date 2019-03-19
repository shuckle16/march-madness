## March Madness Prediction

Using a model built from historical, season level stats to help me fill out my bracket for the 2019 tournament. 

### About the Data

The data has three components:

- Season level stats, for NCAA teams from 1995 to 2019. This is scraped from sports-reference.com. Sadly there is a bias here, sports reference includes data from the post-season each year as well. So I limited the features in my model to only included percentage columns, not any with absolute quantities.

- Tournament-game data from 1995 to 2019. This is from [mmclaughlin87][1] github repository for the years 1995 to 2018. For 2017 and 2018, I dug further into the original source in [this pdf][2]. This data is the source of my dependent variable, which is the sum of the total winnings margin for each team for each year.

- The 2019 [kenpom.com ratings][3].

[1]: https://github.com/mmclaughlin87/march-madness-historical-perfomance
[2]: http://www.hoopstournament.net/StandardReports/By_Year.pdf
[3]: https://kenpom.com/index.php?y=2019
