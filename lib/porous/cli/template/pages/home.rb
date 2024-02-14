class Home
  include Porous::Page
  include Porous::Component

  def route = '/'

  def render
    div class: 'container p-8 mx-auto xl:px-0 flex flex-wrap' do
      div class: 'flex items-center w-full lg:w-1/2' do
        div class: 'max-w-2xl mb-8' do
          h1 class: 'text-4xl font-bold leading-snug tracking-tight text-gray-800 lg:text-4xl lg:leading-tight xl:text-6xl xl:leading-tight dark:text-white' do
            text 'Welcome to Porous'
          end
          p class: 'py-5 text-xl leading-normal text-gray-500 lg:text-xl xl:text-2xl dark:text-gray-300' do
            text 'Porous is an all-in-one application engine for building applications with Web technologies.'
          end

          div class: 'flex flex-col items-start space-y-3 sm:space-x-4 sm:space-y-0 sm:items-center sm:flex-row' do
            a href: 'https://github.com/exastencil/porous', target: '_blank', rel: 'noopener', class: 'px-8 py-4 text-lg font-medium text-center text-white bg-indigo-600 rounded-md' do
              text 'Show on GitHub'
            end
            a href: 'https://github.com/exastencil/porous', target: '_blank', rel: 'noopener', class: 'flex items-center space-x-2 text-gray-500 dark:text-gray-400' do
              svg role: 'img', width: '24', height: '24', class: 'w-5 h-5', viewBox: '0 0 24 24', fill: 'currentColor', xmlns: 'http://www.w3.org/2000/svg' do
                title 'GitHub'
                path d: 'M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12'
              end
              span 'View on GitHub'
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