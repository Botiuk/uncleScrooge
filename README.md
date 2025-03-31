# uncleScrooge

The Numismatic Store "Uncle Scrooge" is the best place to add new items to your collection. 

Built with: Rails 8.0.2, Ruby 3.4.1, postgres, bun, Tailwind, Cloudinary, Trix editor, devise, cancancan, ancestry, pagy.

Test with: RSpec, factory_bot_rails and faker.

Code style checking: RuboCop and his special cops.

My native language is Ukrainian and this is a single language on app. But all interface text was made with I18n and easy to change with translating locale file.

Uncle Scrooge is the main character of one of the Disney studio's favorite childhood cartoons, "DuckTales". In the opening animation of the cartoon, there is a moment when the uncle is bathing in his big stash of coins and is incredibly happy about them. I can confidently say that coins evoke similar emotions in numismatists because I am a numismatist.

The app has two types of users - client and admin. Admin can be created only through db:seed. He can create categories of products, and product pages (with photos, long descriptions, and prices), add a quantity of products to the storehouse, look at and edit the status of client orders, and create sales.

After registration, a client can add products to the cart, and save his delivery addresses and payment cards. When the product is added to the cart, also creates a corresponding record in the storehouse, and the available quantity of the product decreases on the quantity in the cart. All products in the cart are reserved for the client for 24 hours. If after this time he did not create an order, the cart is automatically cleaned and products are available for other clients.

If during the process of adding to the cart, this product takes the other client and the quantity on the storehouse is less than needed shows a special message. Depending on the situation, the product is not added or added but the quantity in the cart is equal last available.

In the shop are discount program. The discount percentage is connected to the amount of all early spent money by current client. Admin also can make orders in the shop and his discount percentage are bigger than in the program and not depend on spent money. When a product has sale, this percentage is also bigger than the discount and does not sum up with it.

On the page header, you can search for the product by name. For admin, on the product page available search for all storehouse operations with this product - very useful for product accounting in physical storehouse.

In the shop, all products are structured by categories. Root categories are also added to the navbar. Each category can have subcategories and they also can have their own subcategories.

On the start page, are two lists of products - one with the last added to the storehouse, and the other with active sales action.