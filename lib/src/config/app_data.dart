import 'package:viniovos/src/models/cart_item_model.dart';
import 'package:viniovos/src/models/item_model.dart';
import 'package:viniovos/src/models/order_model.dart';
import 'package:viniovos/src/models/user_model.dart';

ItemModel ovosVermelho = ItemModel(
  itemName: 'Ovos Vermelho',
  imgUrl: 'assets/fruits/ovosvemelho.jpg',
  price: 19.00,
  unit: 'Und',
  description: 'Ovos Vermelho de Qualidade',
);

ItemModel ovosBranco = ItemModel(
  imgUrl: 'assets/fruits/ovosbranco.png',
  itemName: 'Ovos Branco',
  price: 18.00,
  unit: 'kg',
  description: 'Ovos branco de qualidade.',
);

ItemModel refrigerantesCola = ItemModel(
  imgUrl: 'assets/fruits/refrigerantes.jpg',
  itemName: 'Coca Cola',
  price: 45.00,
  unit: 'Fd 6 und',
  description: 'Refrigerante de cola fardo com 6 und.',
);

List<ItemModel> items = [
  ovosBranco,
  ovosVermelho,
  refrigerantesCola,
];

List<String> categories = [
  'Ovos',
  'Refrigerantes',
];

List<CartItemModel> cartItems = [
  CartItemModel(
    item: ovosBranco,
    quantity: 4,
  ),
];

UserModel user = UserModel(
  phone: '99 9 9999-9999',
  cpf: '999.999.999-99',
  email: 'user@email.com',
  name: 'New User',
  password: '',
);

List<OrderModel> orders = [
  // Pedido 01
  OrderModel(
    copyAndPaste: 'q1w2e3r4t5y6',
    createdDateTime: DateTime.parse(
      '2022-06-08 10:00:10.458',
    ),
    overdueDateTime: DateTime.parse(
      '2022-06-08 11:00:10.458',
    ),
    id: 'asd6a54da6s2d1',
    status: 'pending_payment',
    total: 11.0,
    items: [
      CartItemModel(
        item: ovosBranco,
        quantity: 2,
      ),
    ],
  ),

  // Pedido 02
  OrderModel(
    copyAndPaste: 'q1w2e3r4t5y6',
    createdDateTime: DateTime.parse(
      '2022-06-08 10:00:10.458',
    ),
    overdueDateTime: DateTime.parse(
      '2022-06-08 11:00:10.458',
    ),
    id: 'a65s4d6a2s1d6a5s',
    status: 'delivered',
    total: 11.5,
    items: [
      CartItemModel(
        item: ovosBranco,
        quantity: 1,
      ),
    ],
  ),
];
