package com.example.SLC

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.webkit.WebViewClient
import com.example.SLC.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val webView = binding.webView

        webView.webViewClient = WebViewClient()
        webView.loadUrl("https://slcardu.com/")
        webView.settings.javaScriptEnabled = true
        webView.settings.domStorageEnabled = true


    }
}