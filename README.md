# GDP, Life Expectancy and Wellbeing data analysis and exploration Project with MySQL

## EDA project in MySQL about GDPs, Life Expectancy and Wellbeing of different countries throughout the 8-year period

In this project, I use Power Querying and Versatile Data Manipulation provided by SQL to Analyse data available on Wikipedia about Gross Domestic Products, Life Expectancy and Wellbeing in a form of a grade (0-10). This is my MySQL skill showcase in a form of a project, results of which I was personally interested in knowing as a person interested in economics and human geography. "Life Project" consists of 7 groups of queries, 2 tables and various additions to them.

### See some query result examples
![Best country to live in query result](https://github.com/dimitriousss/nba2k/assets/136066480/4a1aee70-5f0d-4deb-9c67-e278683f965b)
![GDP ranking query result](https://github.com/dimitriousss/nba2k/assets/136066480/49ce5509-50c7-415d-894e-431c611b36c5)
![GDP ranking movement query result](https://github.com/dimitriousss/lifeproject/assets/136066480/38011039-a61b-4bb2-a67b-bd792d92b8f3)
![Life expectancy quartiles query result](https://github.com/dimitriousss/nba2k/assets/136066480/8c03c30e-0c1a-4af3-a66c-8e36093690da)

### Project conclusions:
Findings made from query results are noted below:
- First, second and fourth group are aimed to show progress or regress in measures throughout the given period. It can be seen that there is no clear connection between changes in GDP and Life Expectancy and this relationship will be examined again in group seven (last group);
- Third group is a simple ranking system by each measure. Interesting conclusion from these queries is that there is no countries that appear in all three graphs on top-10 positions in 2013 nor in 2020, which again shows lack of relationship between GDP and other observed measures;
- Third group rankings were added to both tables;
- Fifth group of queries is using the technique of summarising rankings in every measure for countries given in both tables to display which countries are the best and the worst. Switzerland, being the best in both 2013 and 2020 grew in GDP, but had a decline in other measures, while Benin, being the worst in 2020 had much better Life Expectancy and Wellbeing than Zimbabwe in 2013, but two times lower GDP. So, Switzerland established a the best country by the combination of measures, while African countries stay at the lower positions;
- Mean GDP, Life Expectancy and Wellbeing of 2013-2020 were added to the table;
- Sixth group is showing the quartiles of each measure means. Interesting conclusions of these results are that only roughly 25% of countries in the world had more than 100 billion GDPs on average, 50% of the worlds life expectancy was in between 72 and 81 years and only 25% of the world's wellbeing ratings were lower than 5/10;
- Seventh group calculates the Pearson's correlation coefficient between the measures. As said before, Life Expectancy and Wellbeing show low correlation with GDP, it means that both measures are not hardly or not dependant on Domestic Products. Life Expectancy and Wellbeing logically have high positive correlation and it generally is true that to longer life positively affects satisfaction a person gets from it.

@ Dmytro Kvasha
