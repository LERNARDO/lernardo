/*
* dataSource and environments configuration were moved to externalized file "nuedo-config.groovy"
*/

hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class= 'net.sf.ehcache.hibernate.EhCacheProvider'
}
