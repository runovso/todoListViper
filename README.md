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

❓ API returns 30 todos for defferent users by default

➡ Ask tasks only for user with id 1
