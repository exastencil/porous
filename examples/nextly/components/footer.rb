class Footer < Porous::Component
  render :html do
    div class: 'relative' do
      div class: 'container p-8 mx-auto xl:px-0' do
        div class: 'grid max-w-screen-xl grid-cols-1 gap-10 pt-10 mx-auto mt-5 border-t border-gray-100 dark:border-gray-700 lg:grid-cols-5' do
          div class: 'lg:col-span-2' do
            div do
              # whitespace
              a href: '/',
                class: 'flex items-center space-x-2 text-2xl font-medium text-indigo-500 dark:text-gray-100' do
                img src: '/public/img/logo.svg', alt: 'N', width: 32, height: 32, class: 'w-8'
                span { 'Nextly' }
              end
            end

            div class: 'max-w-md mt-4 text-gray-500 dark:text-gray-400' do
              "Nextly is a free landing page & marketing website template for startups and indie projects. It's built with Next.js & TailwindCSS. And it's completely open-source."
            end
          end

          div do
            div class: 'flex flex-wrap w-full -mt-2 -ml-3 lg:ml-0' do
              %W[Product Features Pricing Company Blog].each do |item|
                a href: '/',
                  class: 'w-full px-4 py-2 text-gray-500 rounded-md dark:text-gray-300 hover:text-indigo-500 focus:text-indigo-500 focus:bg-indigo-100 focus:outline-none dark:focus:bg-gray-700' do
                  item
                end
              end
            end
          end

          div do
            div class: 'flex flex-wrap w-full -mt-2 -ml-3 lg:ml-0' do
              ["Terms", "Privacy", "Legal"].each do |item|
                a href: '/',
                  class: 'w-full px-4 py-2 text-gray-500 rounded-md dark:text-gray-300 hover:text-indigo-500 focus:text-indigo-500 focus:bg-indigo-100 focus:outline-none dark:focus:bg-gray-700' do
                  item
                end
              end
            end
          end

          div class: 'text-gray-400 dark:text-gray-500' do
            div { 'Follow us' }
            div class: 'flex mt-5 space-x-5' do
              a href: 'https://twitter.com/web3templates', target: '_blank', rel: 'noopener' do
                span(class: 'sr-only') { 'Twitter' }
                render TwitterLogo
              end
              a href: 'https://facebook.com/web3templates', target: '_blank', rel: 'noopener' do
                span(class: 'sr-only') { 'Facebook' }
                render FacebookLogo
              end
              a href: 'https://instagram.com/web3templates', target: '_blank', rel: 'noopener' do
                span(class: 'sr-only') { 'Instagram' }
                render InstagramLogo
              end
              a href: 'https://linkedin.com', target: '_blank', rel: 'noopener' do
                span(class: 'sr-only') { 'Linkedin' }
                render LinkedinLogo
              end
            end
          end
        end # grid

        div class: 'my-10 text-sm text-center text-gray-600 dark:text-gray-400' do
          text "Copyright © #{Date.today.year}. Made with ♥ by " # whitespace
          a(href: 'https://web3templates.com/', target: '_blank', rel: 'noopener') { 'Web3Templates.' }
          text ' Illustrations from ' # whitespace
          a(href: 'https://www.glazestock.com/', target: '_blank', rel: 'noopener') { 'Glazestock.' }
        end
      end

      a href: 'https://web3templates.com', target: '_blank', rel: 'noopener',
        class: 'absolute flex px-3 py-1 space-x-2 text-sm font-semibold text-gray-900 bg-white border border-gray-300 rounded shadow-sm place-items-center left-5 bottom-5 dark:bg-gray-900 dark:border-gray-700 dark:text-gray-300' do
        svg width: 20, height: 20, viewBox: '0 0 30 30', class: 'w-4 h-4', xmlsns: 'http://www.w3.org/2000/svg' do
          rect width: 30, height: 30, rx: '2.76923', fil: '#362F78'
          path fill: '#F7FAFC',
               d: 'M10.14 21.94H12.24L15.44 12.18L18.64 21.94H20.74L24.88 8H22.64L19.58 18.68L16.36 8.78H14.52L11.32 18.68L8.24 8H6L10.14 21.94Z'
        end

        span { 'Web3Templates' }
      end
    end
  end
end
