const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

environment.plugins.append("Provide", new webpack.ProvidePlugin({
	$: 'jquery',
    jquery: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
}))
environment.config.set('resolve.alias', {jquery: 'jquery/src/jquery'});
module.exports = environment
