class Missing
  include Porous::Page
  include Porous::Component

  def route = '/404'

  def render
    div class: 'container p-8 mx-auto h-full xl:px-0 flex flex-wrap' do
      div class: 'flex items-center w-full lg:w-1/2' do
        div class: 'max-w-2xl mb-8' do
          h1 class: 'text-4xl font-bold leading-snug tracking-tight text-gray-800 lg:text-4xl lg:leading-tight xl:text-6xl xl:leading-tight dark:text-white' do
            text 'Whoops!'
          end
          p class: 'py-5 text-xl leading-normal text-gray-500 lg:text-xl xl:text-2xl dark:text-gray-300' do
            text "The page you're looking for doesn't exist!"
          end

          div class: 'flex flex-col items-start space-y-3 sm:space-x-4 sm:space-y-0 sm:items-center sm:flex-row' do
            a href: '/', rel: 'noopener',
              class: 'px-8 py-4 text-lg font-medium text-center text-white bg-indigo-600 rounded-md' do
              text 'Go back home'
            end
          end
        end
      end

      div class: 'flex items-center justify-center w-full lg:w-1/2' do
        div do
          img src: '/static/hero.png', width: '616', height: '617', class: 'object-cover', alt: 'Hero Illustration'
        end
      end
    end
  end
end
