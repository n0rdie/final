require 'rails_helper'

RSpec.describe 'RecipesFacade' do 
  it '#get recipes search' do
    thailand_json = File.read("spec/fixtures/thailand.json")
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=#{Rails.application.credentials.edamam[:id]}&app_key=#{Rails.application.credentials.edamam[:key]}&q=thailand%7D&type=public").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: thailand_json, headers: {})

    recipes = RecipesFacade.country_search('thailand')

    expect(recipes.count).to eq(20)
    expect(recipes.first).to be_a(RecipePoro)
    expect(recipes.first.country).to eq('thailand')
    expect(recipes.first.title).to eq("Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")
    expect(recipes.first.url).to eq('https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html')
    expect(recipes.first.image).to eq('https://edamam-product-images.s3.amazonaws.com/web-img/611/61165abc1c1c6a185fe5e67167d3e1f0.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEJ%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCIHV1YMKs%2BhU6u%2B32n%2BC%2FHV16lG2Uh29yUti9ZsPAnSHfAiBcsrv5j0ioLR5nWp%2BSBA5F1iRfx36Y7TR99NRix0b94CrCBQiY%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAAaDDE4NzAxNzE1MDk4NiIM16GQwdAMzSg%2BFFmnKpYFfuVcVRgwvMpYEQS0SSGGWPBnY7jcOk4s2ndQ7TctaDI0IWVP%2FGf%2B6L0jK%2Bx7oMzU2rEW4J8wPE%2BcO2LjGmav0ZFOKGGoFlu3p8HV4Hxn7uHLj%2FyGnScT%2FpX5Qo%2FUEi%2FBAkj0waHJk6Serw81cILt29OwSKYAATs1sMUlMgUAGheY5ClvusOVzHpLnvM7kpJ7vr%2FsBSFn5jHnjnWxsml878xxhln91tHsD3oBvpX9%2F5YD9gD4VwFCZoJBBrnxHAZQ8JBJTFcwIys5tLqBCRwg7HD0zlqteMiB%2Fj1m0Oo5EEzEXuebyELIJW2ryHr6TuK6ljKAd70%2BkwEkv17S8SwnF0uXPbV0dQTIa8B7edEPmOF0WmFkxETMd5f4vjb9WVGdaQ%2FsXA%2F7w4CLcfIC5Brb2K9EeES%2BKkI6cR6IgwvBGNkB1KsYoqm5lEQUG0tAk4Gr2e8EU2FiDH39%2Bup6ShT6V%2Fp6k%2FZOUmU9FJc3VLCfNChCSdq8Q6VuTJLUS9OF7spnHbEv%2B7LoLtBgZXFhCbaVrmLYmZd7GzeFN1wYcaPkNOGtDkQvY2dlEfLjMdxCxeLn4TT4Ocd1oRu8wU%2Bqfy5V6a3tIx35PMYiHJfI%2FfyRURuevx964wv7JeihU4oAugc%2Bq6S4p3ifpvpj7Xr%2Bcsi3odkwCYdyClugMTR5I7SQFS7vbeEiNYQ786U1gUNTxkAwbB91guhuk0d1ObGTH8OlxcfaqhkDeBHsVv3H0Gh8DE89KJaEdERiaE6gDvdreZYZa%2F%2F9jKAHjnJcv7yKlfv%2F1WdyQUHF559Z0WPj2wN7O62oQsKgTUtcR8nYeCyss2dRtrOXCmKUTYolSGEaSZ6ZcJs9ILNZfOc6ftqL77tqEFLRqk%2Bjmr8wgsCerwY6sgEWzqsEg0qrSW5dBS9LeGqdsd2Im38iiPtilz867EznVnTL4EAC%2BoD%2F50y%2Fzbck4H%2FRjHl%2BDL%2FkDc7sChiVU9H2MF1LV0QkHyIdEab1DUhZUZRDn%2FxNIUdpPWyJoOEwxGjktihMRyYVYOAz8%2B8PIgOOX5LvfNpE%2FGAs%2B3mlfcGwokE6bK74Q3l%2BWFVNGu4%2F13%2FmzuqVix7arqIZgIeFK9Ir8wdABPFx4qY3tu1eYvu9Zh7%2F&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240305T235613Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFADKECWVK%2F20240305%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=2e6f6c28de048bf922444a3d260f47f1f0a4646421cb883885196c1bd49eed7f')
  end
end