# Personal finance tracker



## Architectural Design and Justification
#### UI state management
Cubit and Bloc has been used for the UI state management. 
For the add transaction feature, a Cubit has been implemented because of the simplicity of the logic. A Bloc adds boilerplate code and it's heavier than a Cubit.

For the list of transactionsi feature, a Bloc has been implemented. Bloc has been choosen to have a bigger control of why something is happening in the app.

That being said, both features could be implemented with Cubit or Bloc, as both approaches allow to have a fine control over the UI changes. 

#### Project structure
The project is organized in layers.
The layers have been created based on the responsibilities of each one. 

* Models: domain objects to represent data.
* Screens: the screens that make up the application. They depend on material.
* Theme: establish the theme of the application and control its persistence.
* Widgets: visual elements that can be used in different screens.

The screens functionality has been organized following the Feature-First approach. Because of this, the screen and the UI state management classes (cubit or bloc) are grouped together in the same folder.

The Layer-First approach could also be used for this project. The greatest advantage of the Feature-First approach is the scalability.


### Future improvements
#### UI
* Improve the add transaction screen
* Error handling
* Improve dark mode

#### Structure
* Create packages for the application layers, such as screens, isolated widgets, business logic, theme, data storage and localizations.
* Separated models for application, business and data layer. This allows the separation of concerts and easier replacement in the future.
* Localizations package. Introduce translations for the languages that should be supported in the app. Language for the user will be the language of his device or default one if not suported.
* Proper route handling with go_router or other route management solution.

#### Error
* Improve the error handling  of the app with custom exceptions and control of edge cases.

#### Trade offs
* The add transaction screen style doesn't match the style of the transactions list screen.
* Localizations is not taken into account, messages are hardcoded in the code.
* Unit tests to validate the logic.
* Automatic integration test
* More customizable theme.

## Requirements
#### Funcionality
1. Add transactions (income/expense) with amount, category, date, and optional notes
2. Display a list of all transactions
3. Show current balance at the top of the screen
4. Filter transactions by type (income/expense/all)
5. Persist data locally so it survives app restarts

#### Technical
* Use Bloc for state management (transactions list, balance calculation, filters)
* Implement theming with light/dark mode toggle (persisted preference)
* Use SharedPreferences for theme preference
* Use a database like SQLite or a persistence framework like Hive for transaction storage
* Follow Flutter best practices and material design guidelines


## Requirements
#### Funcionality
1. Add transactions (income/expense) with amount, category, date, and optional notes
2. Display a list of all transactions
3. Show current balance at the top of the screen
4. Filter transactions by type (income/expense/all)
5. Persist data locally so it survives app restarts

#### Technical
* Use Bloc for state management (transactions list, balance calculation, filters)
* Implement theming with light/dark mode toggle (persisted preference)
* Use SharedPreferences for theme preference
* Use a database like SQLite or a persistence framework like Hive for transaction storage
* Follow Flutter best practices and material design guidelines

## Time spent
I have spent 4 hours and 15 minutes for the application development and half an hour for this documentation.
