const Product = Parse.Object.extend('Product');
const Category = Parse.Object.extend('Category');


Parse.Cloud.define('get-product-list', async (req) => {
	const queryProducts = new Parse.Query(Product);

	//Condições da Query
	if (req.params.title != null) {
		queryProducts.fullText('title', req.params.title);
		//queryProducts.matches('title', '.*' + req.params.title + '.*');
	}

	if (req.params.categoryId != null) {
		const category = new Category();
		category.id = req.params.categoryId;
		//comparar ponteiro por ponteiro
		queryProducts.equalTo('category', category);
	}

	const itemsPorPage = req.params.itemsPorPage || 20;
	if (itemsPorPage > 100) throw 'Quantidade invalida de itens por página';
	queryProducts.skip(itemsPorPage * req.params.page || 0);
	queryProducts.limit(itemsPorPage);

	queryProducts.include('category'); //incluido o ponteiro category na pesquisa, no lugar do id da categoria.

	const resulProducts = await queryProducts.find({ useMasterKey: true });

	return resulProducts.map(function (p) {
		p = p.toJSON();
		return formatProduct(p);
	});
});

Parse.Cloud.define('get-category-list', async (req) => {
	const queryCategories = new Parse.Query(Category);

	const resulCategories = await queryCategories.find({ useMasterKey: true });

	return resulCategories.map(function (c) {
		c = c.toJSON();
		return {
			title: c.title,
			id: c.objectId
		}

	});
});

function formatProduct(productJson) {
	return {
		id: productJson.ObjectId,
		title: productJson.title,
		descricao: productJson.descricao, //parametro opcional na tabela
		price: productJson.price,
		unit: productJson.unit,
		picture: productJson.picture != null ? productJson.picture.url : null, //parametro opcional na tabela
		category: {
			//deixando de retornar todos os dados da cetogoria(ponteiro), para filtar o que queremos.
			title: productJson.category.title,
			id: productJson.category.objectId
		},
	};
}
 module.exports = {formatProduct}