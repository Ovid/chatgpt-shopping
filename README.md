# ChatGPT Does Shopping

When I go shopping, I use the Notes application on my iPhone. I've long hated
it. I add items that I want to buy to a list, I forget that I have duplicate
items, my list is long and when I search for an item I don't see it, I have
duplicates. I wanted a new app, so I asked ChatGPT to build one for me.

![My ChatGPT Shopping App](https://github.com/Ovid/chatgpt-shopping/assets/24634/fae79989-37b9-4226-b505-e4548514b365)


The following was my query:

---

I would like to create a small shopping list app in Swift for the iPhone. I have a newer version of XCode, so I have ContentView instead of Main.storyboard.

1. The app should allow me to enter and delete food items to buy.
1. Each entry should have a checkbox to the left. Unchecked items should appear at the top, checked items at the bottom.
1. At the top of the screen should be a large title which says “Shopping.”
1. At the bottom of the screen should be two buttons. One says “Alpha” and the other says “Frequency.”
1. If I click on the button which says “Alpha”, all items should be sorted first by unchecked and the checked status. A secondary, alphabetical sort for each checked and unchecked section.
1. If I click on the button which says “Frequency,” all items should be sorted first by unchecked and the checked status. A secondary, sort for the frequency with which I first entered or unchecked each item.
1. The application needs storage to save the number of times I’ve entered or unchecked each item.
1. After I close and reopen the app, it should show the list in the last state it was observed.
1. If I delete an item from the list, it should also be deleted from storage.

---

From there, it was asking it to fill in various sections, correct errors I
found, and add a few new features I discovered I wanted.

While I've done some Android development with Kotlin, I have never done iOS
development, nor do I know the Swift programming language.

Note that the app is not perfect, it has an intermittent sorting bug, and I
wrote no tests. However, it works well enough for me.

This project is available under the MIT license.
