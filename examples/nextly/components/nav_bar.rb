class NavBar < Porous::Component
  ITEMS = %w[Product Features Pricing Company Blog]

  render :html do
    div class: 'w-full' do
      nav class: 'container relative flex flex-wrap items-center justify-between p-8 mx-auto lg:justify-between xl:px-0' do
        # Logo
        div class: 'flex flex-wrap items-center justify-between w-full lg:w-auto' do
          a href: '/' do
            span class: 'flex items-center space-x-2 text-2xl font-medium text-indigo-500 dark:text-gray-100' do
              span do
                img src: '/public/img/logo.svg', alt: 'N', width: 32, height: 32, class: 'w-8'
              end
              span { 'Nextly' }
            end
          end
        end

        # Center Menu
        div class: 'hidden text-center lg:flex lg:items-center' do
          ul class: 'items-center justify-end flex-1 pt-6 list-none lg:pt-0 lg:flex' do
            ITEMS.each_with_index do |item, index|
              li class: 'mr-3 nav__item', key: index do
                a href: '/',
                  class: 'inline-block px-4 py-2 text-lg font-normal text-gray-800 no-underline rounded-md dark:text-gray-200 hover:text-indigo-500 focus:text-indigo-500 focus:bg-indigo-100 focus:outline-none dark:focus:bg-gray-800' do
                  item
                end
              end
            end
          end
        end

        div class: 'hidden mr-3 space-x-4 lg:flex nav__item' do
          a href: '/', class: 'px-6 py-2 text-white bg-indigo-600 rounded-md md:ml-5' do
            'Get Started'
          end
        end
      end
    end
  end
end
