<script lang="ts">
  import { onMount } from 'svelte'

  type NavItem = {
    label: string
    target: string
  }

  type ExternalLink = {
    label: string
    href: string
  }

  type Project = {
    title: string
    description: string
    tags: string[]
  }

  type Experience = {
    title: string
    company: string
    period: string
    bullets: string[]
  }

  type LapVideo = {
    title: string
    href: string
    embed: string
  }

  const name = 'Thaer Aldwaik'
  const role = 'Senior Software Engineer'
  const location = 'Washington State, USA'

  const navItems: NavItem[] = [
    { label: 'Projects', target: 'projects' },
    { label: 'Skills', target: 'skills' },
    { label: 'Experience', target: 'experience' },
    { label: 'Contact', target: 'contact' }
  ]

  const highlights = [
    'Identity and Auth: SSO/OIDC, FedRAMP',
    'Cloud and DevOps: AWS, CI/CD, Terraform, containers, Kubernetes',
    'Experience working in high-scale, security-conscious environments'
  ]
  const garageSignals = ['ex-AWS', 'Motorsport', 'Spec E46']

  const links: ExternalLink[] = [
    { label: 'GitHub', href: 'https://github.com/tdwaik' },
    { label: 'LinkedIn', href: 'https://www.linkedin.com/in/tdwaik/' },
    { label: 'Email', href: 'mailto:me@thaer.dev' }
  ]

  const skills = [
    'Java',
    'C# / .NET',
    'Python',
    'AWS',
    'Terraform',
    'Kubernetes',
    'OAuth2 / OIDC / SAML2',
    'Security / IAM',
    'Microservices Architecture',
    'System Design',
    'SQL',
    'Redis / Valkey',
    'CI/CD (GitHub Actions)',
    'FedRAMP Readiness'
  ]

  const projects: Project[] = [
    {
      title: 'Identity Platform Modernization',
      description:
        'Led migration from in-house identity components to a cloud-based provider, improving SSO consistency, policy control, and operational resilience.',
      tags: ['Identity', 'SSO', 'OIDC', 'Security']
    },
    {
      title: 'AWS Data Pipeline and Messaging Systems',
      description:
        'Designed and scaled backend services for high-volume data propagation and B2B messaging workloads with durability and customer impact as core constraints.',
      tags: ['AWS', 'Java', 'Distributed Systems']
    },
    {
      title: 'CI/CD and Infrastructure as Code',
      description:
        'Standardized environments and release workflows using Terraform and automated pipelines, reducing release friction while improving deployment safety.',
      tags: ['Terraform', 'CI/CD', 'Cloud']
    },
    {
      title: 'Reliability and On-Call Readiness',
      description:
        'Improved incident response and reliability through monitoring, stress testing, root-cause analysis, and production hardening runbooks.',
      tags: ['Reliability', 'On-call', 'Observability']
    }
  ]

  const experience: Experience[] = [
    {
      title: 'Senior Software Engineer',
      company: 'Siteimprove.com',
      period: '2023 - Present',
      bullets: [
        'Owned authentication and SSO architecture across internal and third-party integrations.',
        'Drove migration from in-house identity services to a cloud-based identity provider.',
        'Strengthened token, session, middleware, and access-policy controls to improve security and stability.',
        'Partnered with platform and infrastructure teams on release consistency and compliance readiness, including FedRAMP preparation.'
      ]
    },
    {
      title: 'Software Development Engineer',
      company: 'Amazon Web Services (AWS)',
      period: '2017 - 2023',
      bullets: [
        'Designed and shipped features for large-scale data pipelines, propagation systems, and B2B messaging services.',
        'Owned service initiatives end-to-end with emphasis on customer impact, scalability, and maintainability.',
        'Reduced operational overhead through internal tooling and workflow improvements.',
        'Supported 24/7 on-call operations, incident response, and scaling readiness for peak events.'
      ]
    },
    {
      title: 'Software Engineer',
      company: 'Souq.com',
      period: '2014 - 2017',
      bullets: [
        'Delivered product features and technical designs while modernizing legacy systems toward microservices.',
        'Integrated third-party systems and improved internal documentation, code review quality, and engineering standards.',
        'Collaborated with product and program stakeholders on planning, scope, and execution across multiple initiatives.'
      ]
    },
    {
      title: 'Software Engineer',
      company: 'Builders Software Solutions',
      period: '2013 - 2014',
      bullets: [
        'Develop new features for a “Human Resource System (HRS)” based on clients requests.',
        'Participate in design and implementation to move to cloud based service (Using AWS).',
        'Revamp multiple parts of the system.',
        "Setup HRS onsite (local servers) for multiple clients based on their requests."
      ]
    }
  ]

  const lapVideos: LapVideo[] = [
    {
      title: 'Track Lap - Session 1',
      href: 'https://www.youtube.com/watch?v=xbEXERtOmYM',
      embed: 'https://www.youtube-nocookie.com/embed/xbEXERtOmYM'
    },
    {
      title: 'Track Lap - Session 2',
      href: 'https://www.youtube.com/watch?v=S6gGW_vamdY',
      embed: 'https://www.youtube-nocookie.com/embed/S6gGW_vamdY'
    }
  ]

  const year = new Date().getFullYear()

  let theme: 'light' | 'dark' = 'dark'

  function applyTheme(value: 'light' | 'dark') {
    theme = value
    const root = document.documentElement
    root.classList.toggle('dark', value === 'dark')
    root.style.colorScheme = value
    localStorage.setItem('theme', value)
  }

  function toggleTheme() {
    applyTheme(theme === 'dark' ? 'light' : 'dark')
  }

  onMount(() => {
    const stored = localStorage.getItem('theme') as 'light' | 'dark' | null
    if (stored === 'light' || stored === 'dark') {
      applyTheme(stored)
      return
    }

    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches
    applyTheme(prefersDark ? 'dark' : 'light')
  })

  function scrollToId(id: string) {
    const el = document.getElementById(id)
    el?.scrollIntoView({ behavior: 'smooth', block: 'start' })
  }

  function isExternalUrl(url: string) {
    return url.startsWith('http')
  }
</script>

<div class="min-h-screen bg-slate-100 text-slate-900 transition-colors duration-300 dark:bg-neutral-950 dark:text-zinc-100 selection:bg-emerald-300 selection:text-slate-950">
  <div class="pointer-events-none fixed inset-0 -z-10 overflow-hidden">
    <div class="absolute -top-48 left-1/2 h-[38rem] w-[38rem] -translate-x-1/2 rounded-full bg-emerald-300/30 blur-3xl dark:bg-emerald-400/20"></div>
    <div class="absolute -bottom-48 -right-24 h-[32rem] w-[32rem] rounded-full bg-amber-300/30 blur-3xl dark:bg-amber-500/20"></div>
    <div class="absolute inset-0 bg-[radial-gradient(circle_at_1px_1px,rgba(15,23,42,0.09)_1px,transparent_0)] bg-[size:20px_20px] dark:bg-[radial-gradient(circle_at_1px_1px,rgba(255,255,255,0.08)_1px,transparent_0)]"></div>
  </div>

  <header class="sticky top-0 z-40 border-b border-slate-900/5 bg-slate-100/45 backdrop-blur transition-colors dark:border-white/5 dark:bg-neutral-950/35">
    <div class="mx-auto flex h-16 w-full max-w-6xl items-center justify-between px-4 sm:px-6">
      <a
        class="inline-flex items-center gap-2 text-base font-semibold tracking-tight text-slate-800 transition hover:text-slate-950 sm:text-lg dark:text-zinc-200 dark:hover:text-white"
        href="#top"
        onclick={(event) => {
          event.preventDefault()
          scrollToId('top')
        }}
        aria-label="Scroll to top"
      >
        <span class="grid grid-cols-2 gap-[2px] rounded-sm border border-slate-400/40 p-[2px] dark:border-zinc-500/60">
          <span class="h-1 w-1 rounded-[1px] bg-slate-500 dark:bg-zinc-200"></span>
          <span class="h-1 w-1 rounded-[1px] bg-transparent"></span>
          <span class="h-1 w-1 rounded-[1px] bg-transparent"></span>
          <span class="h-1 w-1 rounded-[1px] bg-slate-500 dark:bg-zinc-200"></span>
        </span>
        <span>{name}</span>
      </a>

      <nav class="hidden items-center gap-1 text-sm md:flex">
        {#each navItems as item}
          <button
            class="rounded-full px-3 py-1.5 text-slate-600 transition hover:bg-slate-900/5 hover:text-slate-900 dark:text-zinc-300 dark:hover:bg-white/10 dark:hover:text-white"
            onclick={() => scrollToId(item.target)}
          >
            {item.label}
          </button>
        {/each}
      </nav>

      <div class="flex items-center gap-2">
        <button
          class="rounded-full border border-slate-900/15 px-3 py-1.5 text-sm text-slate-700 transition hover:bg-slate-900/5 dark:border-white/15 dark:text-zinc-200 dark:hover:bg-white/10"
          onclick={toggleTheme}
          aria-label="Toggle theme"
        >
          {theme === 'dark' ? 'Light' : 'Dark'}
        </button>
        <a class="hidden rounded-full border border-slate-900/15 px-3 py-1.5 text-sm text-slate-700 transition hover:bg-slate-900/5 dark:border-white/15 dark:text-zinc-200 dark:hover:bg-white/10 sm:inline-flex" href={links[0].href} target="_blank" rel="noopener noreferrer">GitHub</a>
        <a class="rounded-full bg-slate-900 px-3 py-1.5 text-sm font-medium text-white transition hover:bg-slate-700 dark:bg-emerald-300 dark:text-neutral-950 dark:hover:bg-emerald-200" href={links[2].href}>Email</a>
      </div>
    </div>
  </header>

  <main id="top" class="mx-auto w-full max-w-6xl px-4 sm:px-6">
    <section class="section-reveal py-14 sm:py-18">
      <div class="grid items-start gap-6 lg:grid-cols-[1.25fr_0.75fr]">
        <div>
          <h1 class="mt-5 font-serif text-4xl leading-[1.05] tracking-tight sm:text-6xl">
            Building reliable backend systems
            <span class="block text-slate-500 dark:text-zinc-400">Senior Software Engineer.</span>
          </h1>

          <p class="mt-5 max-w-2xl text-base leading-relaxed text-slate-700 sm:text-lg dark:text-zinc-300">
            I design and deliver backend platforms that scale, stay reliable under pressure, and meet real-world security and compliance demands.
          </p>

          <!-- <div class="mt-6 flex flex-wrap gap-2">
            {#each garageSignals as signal}
              <span class="inline-flex items-center gap-2 rounded-full border border-slate-900/10 bg-white/75 px-3 py-1 text-xs font-mono text-slate-700 dark:border-white/10 dark:bg-zinc-900/70 dark:text-zinc-300">
                <span class="h-1.5 w-1.5 rounded-full bg-amber-500"></span>
                {signal}
              </span>
            {/each}
          </div> -->

          <div class="mt-8 grid gap-3 sm:grid-cols-3">
            {#each highlights as h}
              <div class="hover-lift rounded-2xl border border-slate-900/10 bg-white/70 p-4 backdrop-blur transition-colors dark:border-white/10 dark:bg-white/5">
                <p class="text-sm leading-relaxed text-slate-700 dark:text-zinc-200">{h}</p>
              </div>
            {/each}
          </div>
        </div>

        <aside class="section-reveal rounded-3xl border border-slate-900/10 bg-white/70 p-6 backdrop-blur-xl transition-colors dark:border-white/10 dark:bg-white/5">
          <div class="flex items-center gap-4">
            <div class="grid h-14 w-14 place-items-center rounded-2xl border border-slate-900/10 bg-slate-900/5 dark:border-white/10 dark:bg-black/20">
              <span class="text-xl font-semibold">{name.split(' ').map((n) => n[0]).join('')}</span>
            </div>
            <div>
              <p class="font-semibold">{name}</p>
              <p class="text-sm text-slate-600 dark:text-zinc-300">{role} | ex-AWS</p>
            </div>
          </div>

          <div class="mt-6 space-y-3 text-sm font-mono">
            <div class="flex items-center justify-between text-slate-600 dark:text-zinc-300"><span>Focus</span><span class="text-slate-900 dark:text-zinc-100">Backend | Auth | Infrastructure</span></div>
            <div class="flex items-center justify-between text-slate-600 dark:text-zinc-300"><span>Stack</span><span class="text-slate-900 dark:text-zinc-100">Java | AWS | Terraform</span></div>
            <div class="flex items-center justify-between text-slate-600 dark:text-zinc-300"><span>Location</span><span class="text-slate-900 dark:text-zinc-100">{location}</span></div>
          </div>

          <div class="mt-6 grid grid-cols-2 gap-2">
            {#each links as l}
              <a
                class="inline-flex items-center gap-2 rounded-xl border border-slate-900/10 bg-slate-900/5 px-3 py-2 text-sm font-mono text-slate-700 transition hover:border-emerald-500/40 hover:bg-emerald-500/10 dark:border-white/10 dark:bg-black/20 dark:text-zinc-200"
                href={l.href}
                target={isExternalUrl(l.href) ? '_blank' : undefined}
                rel={isExternalUrl(l.href) ? 'noopener noreferrer' : undefined}
              >
                {l.label}
                <span class="ml-auto text-slate-400 dark:text-zinc-500">-></span>
              </a>
            {/each}
          </div>
        </aside>
      </div>
    </section>

    <section id="projects" class="section-reveal py-10">
      <div class="mb-6 flex items-end justify-between gap-4">
        <div>
          <div class="mb-2 flex gap-1.5">
            <span class="h-1.5 w-6 rounded-full bg-emerald-500/80"></span>
            <span class="h-1.5 w-4 rounded-full bg-amber-500/80"></span>
          </div>
          <h2 class="font-serif text-3xl sm:text-4xl">Projects</h2>
          <p class="mt-1 text-slate-600 dark:text-zinc-400">Selected systems and platform work.</p>
        </div>
        <button class="hidden rounded-full border border-slate-900/20 px-4 py-2 text-sm text-slate-700 transition hover:bg-slate-900/5 sm:inline-flex dark:border-white/20 dark:text-zinc-200 dark:hover:bg-white/10" onclick={() => scrollToId('contact')}>Work with me</button>
      </div>

      <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {#each projects as p}
          <article
            class="hover-lift group relative rounded-2xl border border-slate-900/10 bg-white/70 p-5 transition hover:border-emerald-500/40 hover:shadow-[0_20px_60px_-30px_rgba(16,185,129,0.45)] dark:border-white/10 dark:bg-zinc-900/80"
          >
            <!-- <span class="absolute inset-x-5 top-0 h-[2px] rounded-full bg-gradient-to-r from-emerald-500/70 via-amber-400/70 to-transparent"></span> -->
            <div class="flex items-start justify-between gap-3">
              <h3 class="font-semibold tracking-tight dark:text-zinc-50">{p.title}</h3>
              <span class="text-slate-400 transition group-hover:text-emerald-500 dark:text-zinc-500 dark:group-hover:text-emerald-300">-></span>
            </div>
            <p class="mt-2 text-sm leading-relaxed text-slate-700 dark:text-zinc-200">{p.description}</p>
            <div class="mt-4 flex flex-wrap gap-2">
              {#each p.tags as t}
                <span class="rounded-full border border-slate-900/10 bg-slate-900/5 px-2.5 py-1 text-xs font-mono text-slate-700 dark:border-zinc-700 dark:bg-zinc-800 dark:text-zinc-100">{t}</span>
              {/each}
            </div>
          </article>
        {/each}
      </div>
    </section>

    <section id="skills" class="section-reveal py-10">
      <h2 class="font-serif text-3xl sm:text-4xl">Skills</h2>
      <p class="mt-1 text-slate-600 dark:text-zinc-400">Tools I use frequently.</p>

      <div class="mt-6 rounded-2xl border border-slate-900/10 bg-white/70 p-5 dark:border-white/10 dark:bg-white/5">
        <div class="flex flex-wrap gap-2">
          {#each skills as s}
            <span class="rounded-full border border-slate-900/10 bg-slate-900/5 px-3 py-1.5 text-sm font-mono text-slate-700 dark:border-white/10 dark:bg-black/25 dark:text-zinc-200">{s}</span>
          {/each}
        </div>
      </div>
    </section>

    <section id="experience" class="section-reveal py-10">
      <h2 class="font-serif text-3xl sm:text-4xl">Experience</h2>
      <p class="mt-1 text-slate-600 dark:text-zinc-400">Career highlights in ownership, scale, and reliability.</p>

      <div class="mt-6 space-y-4">
        {#each experience as e}
          <div class="hover-lift rounded-2xl border border-slate-900/10 bg-white/70 p-6 dark:border-white/10 dark:bg-white/5">
            <div class="flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between">
              <div>
                <h3 class="font-semibold tracking-tight">{e.company}</h3>
                <p class="text-sm text-slate-600 dark:text-zinc-300">{e.title}</p>
              </div>
              <p class="text-sm font-mono text-slate-500 dark:text-zinc-400">{e.period}</p>
            </div>

            <ul class="mt-4 space-y-2 text-sm text-slate-700 dark:text-zinc-300">
              {#each e.bullets as b}
                <li class="flex gap-2">
                  <span class="mt-[7px] h-1.5 w-1.5 flex-none rounded-full bg-emerald-500 dark:bg-emerald-300"></span>
                  <span>{b}</span>
                </li>
              {/each}
            </ul>
          </div>
        {/each}
      </div>
    </section>

    <section id="track-laps" class="section-reveal py-10">
      <h2 class="font-serif text-3xl sm:text-4xl">Track Laps</h2>
      <p class="mt-1 text-slate-600 dark:text-zinc-400">A side pursuit that keeps my telemetry and feedback-loop mindset sharp. Yes, I profile code and lap times.</p>

      <div class="mt-6 grid gap-4 sm:grid-cols-2">
        {#each lapVideos as lap}
          <article class="hover-lift overflow-hidden rounded-2xl border border-slate-900/10 bg-white/70 transition hover:border-emerald-500/40 hover:shadow-[0_20px_60px_-30px_rgba(16,185,129,0.45)] dark:border-white/10 dark:bg-zinc-900/80">
            <div class="aspect-video w-full">
              <iframe
                class="h-full w-full"
                src={lap.embed}
                title={lap.title}
                loading="lazy"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                referrerpolicy="strict-origin-when-cross-origin"
                allowfullscreen
              ></iframe>
            </div>
            <div class="p-4">
              <p class="font-semibold tracking-tight dark:text-zinc-50">{lap.title}</p>
              <a class="mt-1 inline-block text-sm text-slate-600 underline decoration-emerald-500/70 underline-offset-4 dark:text-zinc-400" href={lap.href} target="_blank" rel="noopener noreferrer">Watch on YouTube</a>
            </div>
          </article>
        {/each}
      </div>
    </section>

    <section id="contact" class="section-reveal py-10 pb-16">
      <div class="hover-lift rounded-3xl border border-emerald-500/30 bg-gradient-to-br from-emerald-100/70 to-amber-100/70 p-7 dark:from-emerald-300/15 dark:to-amber-500/15">
        <div class="flex flex-col gap-6 md:flex-row md:items-center md:justify-between">
          <div>
            <h2 class="font-serif text-3xl">Let's build something useful.</h2>
            <p class="mt-2 max-w-xl text-slate-700 dark:text-zinc-300">
              If you are hiring for senior backend, identity, or platform engineering, send a quick note with the problem space and desired outcomes.
            </p>
          </div>

          <div class="flex flex-wrap gap-3">
            <a class="rounded-full bg-slate-900 px-4 py-2 text-sm font-semibold text-white transition hover:bg-slate-700 dark:bg-emerald-300 dark:text-neutral-950 dark:hover:bg-emerald-200" href={links[2].href}>Email me</a>
            <a class="rounded-full border border-slate-900/20 px-4 py-2 text-sm text-slate-800 transition hover:bg-slate-900/5 dark:border-white/20 dark:text-zinc-100 dark:hover:bg-white/10" href={links[1].href} target="_blank" rel="noopener noreferrer">LinkedIn</a>
            <a class="rounded-full border border-slate-900/20 px-4 py-2 text-sm text-slate-800 transition hover:bg-slate-900/5 dark:border-white/20 dark:text-zinc-100 dark:hover:bg-white/10" href={links[0].href} target="_blank" rel="noopener noreferrer">GitHub</a>
          </div>
        </div>
      </div>
    </section>

    <footer class="pb-10 text-center text-xs text-slate-500 dark:text-zinc-500">
      Copyright {year} {name}.
      <span class="ml-1">Built with AI-assisted development, coffee, and careful rollback plans.</span>
    </footer>
  </main>
</div>
