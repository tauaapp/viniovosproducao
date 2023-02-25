const Order = Parse.Object.extend('Order');
const OrderItem = Parse.Object.extend('OrderItem');

const product = require('./product');

Parse.Cloud.define('checkout', async (req) => {
	if(req.user == null) throw 'INVALID_USER';
	//buscar os itens do carrinho
	const queryCartItems = new Parse.Query(CartItem);
	queryCartItems.equalTo('user', req.user);
	queryCartItems.include('product');
	const resultCartItems = await queryCartItems.find({useMasterKey: true});
	
	//calculou o total
	let total = 0;
	for(let item of resultCartItems) {
		item = item.toJSON();
		total += item.quantity * item.product.price;
	}
	
	//verificar se o toal é válido
	if(req.params.total != total) throw 'INVALID_TOTAL';
	
	//criou um pedido
	const order = new Order();
	order.set('total', total);
	order.set('user', req.user);
	const savedOrder = await order.save(null, {useMasterKey: true});
	
	//criou os itens do carrinho
	for(let item of resultCartItems) {
		const orderItem = new OrderItem();
		orderItem.set('order', savedOrder);
		orderItem.set('product', item.get('product'));
		orderItem.set('quantity', item.get('quantity'));
		orderItem.set('price', item.toJSON().product.price);
		await orderItem.save(null, {useMasterKey: true});

	}

	await Parse.Object.destroyAll(resultCartItems, {useMasterKey:true});

	return {
		id: savedOrder.id
	}
});

Parse.Cloud.define('get-orders', async (req) => {
	if(req.user == null) throw 'INVALID_USER';
	
	const queryOrders = new Parse.Query(Order);
	queryOrders.equalTo('user', req.user);
	const resultOrders = await queryOrders.find({useMasterKey: true});
	return resultOrders.map(function (o) {
		o = o.toJSON();
		return {
			id: o.objectId,
			total: o.total,
			createdAt: o.createdAt
		}
	
	});
});

Parse.Cloud.define('get-orders-items', async (req) => {
	if(req.user == null) throw 'INVALID_USER';
	if(req.params.orderId == null) throw 'IVALID_ORDER';

	const order = new Order();
	order.id = req.params.orderId;
	
	const queryOrdersItems = new Parse.Query(OrderItem);
	queryOrdersItems.equalTo('order', order);
	queryOrdersItems.include('product');
	queryOrdersItems.include('product.category');
	const resultOrdesItems = await queryOrdersItems.find({useMasterKey: true});
	return resultOrdesItems.map(function (o){
		o = o.toJSON();
		return {
			id: o.objectId,
			quantity: o.quantity,
			price: o.price,
			product: product.formatProduct(o.product)
		}
	});
});