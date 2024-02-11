class Home < Porous::Page
  # Source: https://github.com/web3templates/nextly-template/blob/main/pages/index.js
  render :html do
    html do
      head do
        title do
          'Nextly - Free Nextjs & TailwindCSS Landing Page Template'
        end
        meta name: 'description', content: 'Nextly is a free landing page template built with next.js & Tailwind CSS'
        link rel: 'icon', href: '/favicon.ico'
        link rel: 'stylesheet', href: '"https://fonts.googleapis.com/css2?family=Inter:wght@400..700&display=swap'
        script src: "https://cdn.tailwindcss.com"
      end

      body class: 'dark:bg-gray-900' do
        render NavBar
        render Hero

        render SectionTitle.new(pretitle: 'Nextly Benefits', title: 'Why should you use this landing page') do
          "Nextly is a free landing page & marketing website template for startups and indie projects. It's built with Next.js & TailwindCSS. And it's completely open-source."
        end

        render Benefits.new(
          title: "Highlight your benefits",
          desc: "You can use this space to highlight your first benefit or a feature of your product. It can also contain an image or Illustration like in the example along with some bullet points.",
          image: '/public/img/benefit-one.png',
          bullets: [
            {
              title: "Understand your customers",
              desc: "Then explain the first point breifly in one or two lines.",
              icon: FaceSmileIcon,
            },
            {
              title: "Improve acquisition",
              desc: "Here you can add the next benefit point.",
              icon: ChartBarSquareIcon,
            },
            {
              title: "Drive customer retention",
              desc: "This will be your last bullet point in this section.",
              icon: CursorArrowRaysIcon,
            },
          ],
        )
        render Benefits.new(
          title: "Offer more benefits here",
          desc: "You can use this same layout with a flipped image to highlight the rest of the benefits of your product. It can also contain an image or illustration as with the above section along with some bullet points.",
          image: '/public/img/benefit-two.png',
          side: 'right',
          bullets: [
            {
              title: "Mobile Responsive Template",
              desc: "Nextly is designed as a mobile first responsive template.",
              icon: DevicePhoneMobileIcon,
            },
            {
              title: "Powered by Next.js & TailwindCSS",
              desc: "This template is powered by latest technologies and tools.",
              icon: AdjustmentsHorizontalIcon,
            },
            {
              title: "Dark & Light Mode",
              desc: "Nextly comes with a zero-config light & dark mode. ",
              icon: SunIcon,
            },
          ],
        )

        render SectionTitle.new(pretitle: 'Watch a video', title: 'Learn how to fullfil your needs') do
          "This section is to highlight a promo or demo video of your product. Analysts say a landing page with video has 3% more conversion rate. So, don't forget to add one. Just like this."
        end
        render Video

        render SectionTitle.new(pretitle: 'Testimonials', title: "Here's what our customers said") do
          "Testimonials are a great way to increase the brand trust and awareness. Use this section to highlight your popular customers."
        end
        render Testimonials

        render SectionTitle.new(pretitle: 'FAQ', title: 'Frequently Asked Questions') do
          "Answer your customers' possible questions here. It will increase the conversion rate as well as support or chat requests."
        end
        render FrequentlyAskedQuestions

        render CallToAction

        render Footer
      end
    end
  end
end
