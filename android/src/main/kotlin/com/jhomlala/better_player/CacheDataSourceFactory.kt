package com.jhomlala.better_player

import android.content.Context
import com.google.android.exoplayer2.upstream.DataSource
import com.google.android.exoplayer2.upstream.DefaultDataSourceFactory
import com.google.android.exoplayer2.upstream.cache.CacheDataSource
import com.google.android.exoplayer2.upstream.FileDataSource
import com.google.android.exoplayer2.upstream.cache.CacheDataSink
import com.google.android.exoplayer2.upstream.DefaultBandwidthMeter

internal class CacheDataSourceFactory(
    private val context: Context,
    private val maxCacheSize: Long,
    private val maxFileSize: Long,
    upstreamDataSource: DataSource.Factory?
) : DataSource.Factory {
    private val defaultDatasourceFactory: DefaultDataSourceFactory
    override fun createDataSource(): CacheDataSource {
        val betterPlayerCache = BetterPlayerCache.createCache(context, maxCacheSize)
            ?: throw IllegalStateException("Cache can't be null.")

        return CacheDataSource(
            betterPlayerCache,
            defaultDatasourceFactory.createDataSource(),
            FileDataSource(),
            CacheDataSink(betterPlayerCache, maxFileSize),


            // FLAG_BLOCK_ON_CACHE:
            //A flag indicating whether we will block reads if the cache key is locked.
            // If unset then data is read from upstream if the cache key is locked, regardless of whether the data is cached.

            // FLAG_IGNORE_CACHE_ON_ERROR:
            // A flag indicating whether the cache is bypassed following any cache related error.
            // If set then cache related exceptions may be thrown for one cycle of open, read and close calls. Subsequent cycles of these calls will then bypass the cache.
            CacheDataSource.FLAG_BLOCK_ON_CACHE or CacheDataSource.FLAG_IGNORE_CACHE_ON_ERROR,
            null
        )
    }

    init {
        val bandwidthMeter = DefaultBandwidthMeter.Builder(context).build()
        defaultDatasourceFactory =
            DefaultDataSourceFactory(context, bandwidthMeter, upstreamDataSource!!)
    }
}