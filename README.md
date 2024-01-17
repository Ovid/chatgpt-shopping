# ChatGPT Does Shopping

When I go shopping, I use the Notes application on my iPhone. I've long hated
it. I add items that I want to buy to a list, I forget that I have duplicate
items, my list is long and when I search for an item I don't see it, I have
duplicates. I wanted a new app, so I asked ChatGPT to build one for me.

I now use this app for shopping and it's much easier to use.

![My ChatGPT Shopping App](https://github.com/Ovid/chatgpt-shopping/assets/24634/d73d6f41-c12e-4a9b-a461-ec20b7d48bc6)

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

I am continuing to add new features to the appliction, small adjustments, one at
a time, while I learn more about what I want and what I can do. You can [follow
along with my original session building the application](https://docs.google.com/document/d/1gDMIBPKL2eb4ublOI0cgNeF2AqciNtF64mYpAqiUUOE/edit?usp=sharing).

This project is available under the MIT license.
