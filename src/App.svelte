<script lang="ts">
  import { onMount } from 'svelte'

  const name = 'Thaer Aldwaik'
  const role = 'Senior Backend Engineer'
  const location = 'Washington State, USA'

  const highlights = [
    'Identity and Auth: SSO/OIDC, FusionAuth, platform integrations',
    'Cloud and DevOps: AWS, CI/CD, Terraform, containers, Kubernetes',
    'Engineering: .NET/C#, Java, React, secure-by-default systems'
  ]

  const links = [
    { label: 'GitHub', href: 'https://github.com/tdwaik' },
    { label: 'LinkedIn', href: 'https://www.linkedin.com/in/tdwaik/' },
    { label: 'Email', href: 'mailto:me@thaer.dev' }
  ]

  const skills = [
    'C# / .NET',
    'AWS',
    'Terraform',
    'Kubernetes',
    'OIDC / SSO',
    'Security',
    'Java',
    'React',
    'PostgreSQL',
    'Redis/Valkey',
    'GitHub Actions',
    'Observability'
  ]

  const projects = [
    {
      title: 'Local-first AI Assistant (Tauri + Svelte)',
      description:
        'A privacy-first desktop assistant with persistent memory, multi-tool integration, and agent-level actions.',
      tags: ['Tauri', 'Svelte', 'Rust', 'Local-first'],
      href: '#'
    },
    {
      title: 'Identity Platform Modernization',
      description:
        'SSO improvements, OIDC integrations, and secure session middleware across a multi-app ecosystem.',
      tags: ['.NET', 'OIDC', 'Security'],
      href: '#'
    },
    {
      title: 'CI/CD and Infrastructure as Code',
      description:
        'Standardized environments with Terraform, automated deployments, and safer releases via GitHub workflows.',
      tags: ['Terraform', 'AWS', 'CI/CD'],
      href: '#'
    },
    {
      title: 'Track Car Build (Spec E46)',
      description:
        'A long-term project: engineering decisions, safety, setup iterations, and data-driven improvements.',
      tags: ['Motorsports', 'DIY', 'Data'],
      href: '#'
    }
  ]

  const experience = [
    {
      title: 'Senior Backend Engineer - Identity / Auth',
      company: 'Siteimprove',
      period: '2023 - Present',
      bullets: [
        'Built and maintained authentication/SSO flows across internal and third-party apps.',
        'Improved reliability and security posture for tokens, sessions, middleware, and policies.',
        'Worked with CI/CD and infrastructure teams to standardize deployments and environments.'
      ]
    },
    {
      title: 'Backend Engineer',
      company: 'Previous Company',
      period: '2020 - 2023',
      bullets: [
        'Delivered APIs, services, and integrations with strong observability and testing.',
        'Worked on performance improvements and production hardening.'
      ]
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
</script>

<div class="min-h-screen bg-slate-100 text-slate-900 transition-colors duration-300 dark:bg-neutral-950 dark:text-zinc-100 selection:bg-emerald-300 selection:text-slate-950">
  <div class="pointer-events-none fixed inset-0 -z-10 overflow-hidden">
    <div class="absolute -top-48 left-1/2 h-[38rem] w-[38rem] -translate-x-1/2 rounded-full bg-emerald-300/30 blur-3xl dark:bg-emerald-400/20"></div>
    <div class="absolute -bottom-48 -right-24 h-[32rem] w-[32rem] rounded-full bg-amber-300/30 blur-3xl dark:bg-amber-500/20"></div>
    <div class="absolute inset-0 bg-[radial-gradient(circle_at_1px_1px,rgba(15,23,42,0.09)_1px,transparent_0)] bg-[size:20px_20px] dark:bg-[radial-gradient(circle_at_1px_1px,rgba(255,255,255,0.08)_1px,transparent_0)]"></div>
  </div>

  <header class="sticky top-0 z-40 border-b border-slate-900/5 bg-slate-100/45 backdrop-blur transition-colors dark:border-white/5 dark:bg-neutral-950/35">
  <!-- <header class="sticky top-0 z-40 backdrop-blur supports-[backdrop-filter]:bg-surface/65 bg-surface/80 border-b border-white/10"> -->
    <div class="mx-auto flex h-16 w-full max-w-6xl items-center justify-between px-4 sm:px-6">
      <button
        class="group inline-flex items-center gap-2 rounded-full border border-slate-900/10 bg-white/80 px-3 py-1.5 text-sm transition hover:bg-white dark:border-white/10 dark:bg-white/5 dark:hover:bg-white/10"
        onclick={() => scrollToId('top')}
        aria-label="Go to top"
      >
        <span class="h-2 w-2 rounded-full bg-emerald-500 shadow-[0_0_14px_rgba(16,185,129,.8)]"></span>
        <span class="font-medium tracking-tight">{name}</span>
      </button>

      <nav class="hidden items-center gap-1 text-sm md:flex">
        <button class="rounded-full px-3 py-1.5 text-slate-600 transition hover:bg-slate-900/5 hover:text-slate-900 dark:text-zinc-300 dark:hover:bg-white/10 dark:hover:text-white" onclick={() => scrollToId('projects')}>Projects</button>
        <button class="rounded-full px-3 py-1.5 text-slate-600 transition hover:bg-slate-900/5 hover:text-slate-900 dark:text-zinc-300 dark:hover:bg-white/10 dark:hover:text-white" onclick={() => scrollToId('skills')}>Skills</button>
        <button class="rounded-full px-3 py-1.5 text-slate-600 transition hover:bg-slate-900/5 hover:text-slate-900 dark:text-zinc-300 dark:hover:bg-white/10 dark:hover:text-white" onclick={() => scrollToId('experience')}>Experience</button>
        <button class="rounded-full px-3 py-1.5 text-slate-600 transition hover:bg-slate-900/5 hover:text-slate-900 dark:text-zinc-300 dark:hover:bg-white/10 dark:hover:text-white" onclick={() => scrollToId('contact')}>Contact</button>
      </nav>

      <div class="flex items-center gap-2">
        <button
          class="rounded-full border border-slate-900/15 px-3 py-1.5 text-sm text-slate-700 transition hover:bg-slate-900/5 dark:border-white/15 dark:text-zinc-200 dark:hover:bg-white/10"
          onclick={toggleTheme}
          aria-label="Toggle theme"
        >
          {theme === 'dark' ? 'Light' : 'Dark'}
        </button>
        <a class="hidden rounded-full border border-slate-900/15 px-3 py-1.5 text-sm text-slate-700 transition hover:bg-slate-900/5 dark:border-white/15 dark:text-zinc-200 dark:hover:bg-white/10 sm:inline-flex" href={links[0].href} target="_blank" rel="noreferrer">GitHub</a>
        <a class="rounded-full bg-slate-900 px-3 py-1.5 text-sm font-medium text-white transition hover:bg-slate-700 dark:bg-emerald-300 dark:text-neutral-950 dark:hover:bg-emerald-200" href={links[2].href}>Email</a>
      </div>
    </div>
  </header>

  <main id="top" class="mx-auto w-full max-w-6xl px-4 sm:px-6">
    <section class="py-14 sm:py-18">
      <div class="grid items-start gap-6 lg:grid-cols-[1.25fr_0.75fr]">
        <div>
          <p class="inline-flex items-center gap-2 rounded-full border border-slate-900/10 bg-white/70 px-3 py-1 text-xs text-slate-700 dark:border-white/15 dark:bg-white/5 dark:text-zinc-300">
            <span class="h-1.5 w-1.5 rounded-full bg-emerald-500"></span>
            Available for select projects | {location}
          </p>

          <h1 class="mt-5 font-serif text-4xl leading-[1.05] tracking-tight sm:text-6xl">
            Building secure backend systems
            <span class="block text-slate-500 dark:text-zinc-400">with clean delivery pipelines.</span>
          </h1>

          <p class="mt-5 max-w-2xl text-base leading-relaxed text-slate-700 sm:text-lg dark:text-zinc-300">
            I am {name}, a {role} focused on identity, cloud platform work, and production reliability. I turn complex requirements into simple systems that teams can run with confidence.
          </p>

          <!-- <div class="mt-7 flex flex-wrap gap-3">
            <button class="rounded-full bg-slate-900 px-5 py-2.5 text-sm font-medium text-white transition hover:bg-slate-700 dark:bg-white dark:text-neutral-950 dark:hover:bg-zinc-200" onclick={() => scrollToId('projects')}>View projects</button>
            <a class="rounded-full border border-slate-900/20 bg-white/70 px-5 py-2.5 text-sm font-medium text-slate-800 transition hover:bg-white dark:border-white/20 dark:bg-transparent dark:text-zinc-100 dark:hover:bg-white/10" href={links[1].href} target="_blank" rel="noreferrer">LinkedIn</a>
          </div> -->

          <div class="mt-8 grid gap-3 sm:grid-cols-3">
            {#each highlights as h}
              <div class="rounded-2xl border border-slate-900/10 bg-white/70 p-4 backdrop-blur transition-colors dark:border-white/10 dark:bg-white/5">
                <p class="text-sm leading-relaxed text-slate-700 dark:text-zinc-200">{h}</p>
              </div>
            {/each}
          </div>
        </div>

        <aside class="rounded-3xl border border-slate-900/10 bg-white/70 p-6 backdrop-blur-xl transition-colors dark:border-white/10 dark:bg-white/5">
          <div class="flex items-center gap-4">
            <div class="grid h-14 w-14 place-items-center rounded-2xl border border-slate-900/10 bg-slate-900/5 dark:border-white/10 dark:bg-black/20">
              <span class="text-xl font-semibold">{name.split(' ').map((n) => n[0]).join('')}</span>
            </div>
            <div>
              <p class="font-semibold">{name}</p>
              <p class="text-sm text-slate-600 dark:text-zinc-300">{role}</p>
            </div>
          </div>

          <div class="mt-6 space-y-3 text-sm">
            <div class="flex items-center justify-between text-slate-600 dark:text-zinc-300"><span>Focus</span><span class="text-slate-900 dark:text-zinc-100">Identity | Cloud | Security</span></div>
            <div class="flex items-center justify-between text-slate-600 dark:text-zinc-300"><span>Stack</span><span class="text-slate-900 dark:text-zinc-100">JAVA | AWS | Terraform</span></div>
            <div class="flex items-center justify-between text-slate-600 dark:text-zinc-300"><span>Location</span><span class="text-slate-900 dark:text-zinc-100">{location}</span></div>
          </div>

          <div class="mt-6 grid grid-cols-2 gap-2">
            {#each links as l}
              <a
                class="inline-flex items-center gap-2 rounded-xl border border-slate-900/10 bg-slate-900/5 px-3 py-2 text-sm text-slate-700 transition hover:border-emerald-500/40 hover:bg-emerald-500/10 dark:border-white/10 dark:bg-black/20 dark:text-zinc-200"
                href={l.href}
                target={l.href.startsWith('http') ? '_blank' : undefined}
                rel="noreferrer"
              >
                {l.label}
                <span class="ml-auto text-slate-400 dark:text-zinc-500">-></span>
              </a>
            {/each}
          </div>
        </aside>
      </div>
    </section>

    <section id="projects" class="py-10">
      <div class="mb-6 flex items-end justify-between gap-4">
        <div>
          <h2 class="font-serif text-3xl sm:text-4xl">Projects</h2>
          <p class="mt-1 text-slate-600 dark:text-zinc-400">Selected systems and platform work.</p>
        </div>
        <button class="hidden rounded-full border border-slate-900/20 px-4 py-2 text-sm text-slate-700 transition hover:bg-slate-900/5 sm:inline-flex dark:border-white/20 dark:text-zinc-200 dark:hover:bg-white/10" onclick={() => scrollToId('contact')}>Work with me</button>
      </div>

      <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {#each projects as p}
          <a
            class="group rounded-2xl border border-slate-900/10 bg-white/70 p-5 transition hover:-translate-y-0.5 hover:border-emerald-500/40 hover:shadow-[0_20px_60px_-30px_rgba(16,185,129,0.45)] dark:border-white/10 dark:bg-zinc-900/80"
            href={p.href}
            target={p.href.startsWith('http') ? '_blank' : undefined}
            rel="noreferrer"
          >
            <div class="flex items-start justify-between gap-3">
              <h3 class="font-semibold tracking-tight dark:text-zinc-50">{p.title}</h3>
              <span class="text-slate-400 transition group-hover:text-emerald-500 dark:text-zinc-500 dark:group-hover:text-emerald-300">-></span>
            </div>
            <p class="mt-2 text-sm leading-relaxed text-slate-700 dark:text-zinc-200">{p.description}</p>
            <div class="mt-4 flex flex-wrap gap-2">
              {#each p.tags as t}
                <span class="rounded-full border border-slate-900/10 bg-slate-900/5 px-2.5 py-1 text-xs text-slate-700 dark:border-zinc-700 dark:bg-zinc-800 dark:text-zinc-100">{t}</span>
              {/each}
            </div>
          </a>
        {/each}
      </div>
    </section>

    <section id="skills" class="py-10">
      <h2 class="font-serif text-3xl sm:text-4xl">Skills</h2>
      <p class="mt-1 text-slate-600 dark:text-zinc-400">Tools I use frequently.</p>

      <div class="mt-6 rounded-2xl border border-slate-900/10 bg-white/70 p-5 dark:border-white/10 dark:bg-white/5">
        <div class="flex flex-wrap gap-2">
          {#each skills as s}
            <span class="rounded-full border border-slate-900/10 bg-slate-900/5 px-3 py-1.5 text-sm text-slate-700 dark:border-white/10 dark:bg-black/25 dark:text-zinc-200">{s}</span>
          {/each}
        </div>
      </div>
    </section>

    <section id="experience" class="py-10">
      <h2 class="font-serif text-3xl sm:text-4xl">Experience</h2>
      <p class="mt-1 text-slate-600 dark:text-zinc-400">Recent roles and outcomes.</p>

      <div class="mt-6 space-y-4">
        {#each experience as e}
          <div class="rounded-2xl border border-slate-900/10 bg-white/70 p-6 dark:border-white/10 dark:bg-white/5">
            <div class="flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between">
              <div>
                <h3 class="font-semibold tracking-tight">{e.title}</h3>
                <p class="text-sm text-slate-600 dark:text-zinc-300">{e.company}</p>
              </div>
              <p class="text-sm text-slate-500 dark:text-zinc-400">{e.period}</p>
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

    <section id="contact" class="py-10 pb-16">
      <div class="rounded-3xl border border-emerald-500/30 bg-gradient-to-br from-emerald-100/70 to-amber-100/70 p-7 dark:from-emerald-300/15 dark:to-amber-500/15">
        <div class="flex flex-col gap-6 md:flex-row md:items-center md:justify-between">
          <div>
            <h2 class="font-serif text-3xl">Lets build something useful.</h2>
            <p class="mt-2 max-w-xl text-slate-700 dark:text-zinc-300">
              Want to collaborate or hire me? Send a quick note with what you are building and what success looks like.
            </p>
          </div>

          <div class="flex flex-wrap gap-3">
            <a class="rounded-full bg-slate-900 px-4 py-2 text-sm font-semibold text-white transition hover:bg-slate-700 dark:bg-emerald-300 dark:text-neutral-950 dark:hover:bg-emerald-200" href={links[2].href}>Email me</a>
            <a class="rounded-full border border-slate-900/20 px-4 py-2 text-sm text-slate-800 transition hover:bg-slate-900/5 dark:border-white/20 dark:text-zinc-100 dark:hover:bg-white/10" href={links[1].href} target="_blank" rel="noreferrer">LinkedIn</a>
            <a class="rounded-full border border-slate-900/20 px-4 py-2 text-sm text-slate-800 transition hover:bg-slate-900/5 dark:border-white/20 dark:text-zinc-100 dark:hover:bg-white/10" href={links[0].href} target="_blank" rel="noreferrer">GitHub</a>
          </div>
        </div>
      </div>
    </section>

    <footer class="pb-10 text-center text-xs text-slate-500 dark:text-zinc-500">
      Copyright {year} {name}.
    </footer>
  </main>
</div>

