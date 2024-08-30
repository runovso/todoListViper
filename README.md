# ToDo List on VIPER
A small project for practicing VIPER architecture. Based on test assignment from EffectiveMobile.

### Test assignment requirements
Link to the original doc: https://docs.google.com/document/d/1nz0rdVnwTDID2G9aBGwLfJFR6Afx2Od08ys-k05S8ZM/edit
- Task should have a title, description, creation date and status (completed or not);
- There should be an opportunity to add a new task and edit or delete existing one;
- At fist start app should ask https://dummyjson.com/todos API for initial list of task;
- Task creation, editind and deleting should proceed on the background thread using CGD or NSOperation and should not block UI;
- App should store tasks using CoreData;
- VIPER architecture;
- Unit tests for major components

### Issues and decisions:

❓ API returns 30 todos for defferent users by default. It's to many for a single screen
➡ Ask tasks only for user with id 1

❓ Tasks from API have random Int identifier, so it's not clear how to generate new unique identifiers for new tasks

➡ Before setting an identifier to the new task, Int.random(in 0...Int(Int16.max)) is being called and then its result compares to the list of all of existing tasks' indentifiers; if there is a match — repeat, if not — assign result as identifier
