# Roteiro de Apresentação — Kubernetes: o que é esse negócio que todo mundo fala

**Evento:** DOUGBR Meetup · UNIFAAT · Atibaia  
**Palestrante:** Emerson Silva · 4Linux  
**Tempo total estimado:** 40–50 min + 10 min perguntas  

---

## Slide 1 — Título (2 min)

> **Tom:** Energético. Não comece com "bom dia, meu nome é...". Entre com uma pergunta.

"Antes de começar, quero fazer uma pergunta rápida — levanta a mão quem já ouviu falar de Kubernetes."

_[pausa, observa as mãos]_

"Ótimo. Agora mantém a mão levantada quem consegue explicar o que ele faz em uma frase."

_[pausa — normalmente muitas mãos caem]_

"É exatamente pra isso que a gente está aqui. Quando essa palestra acabar, você vai conseguir responder essa pergunta — e ainda sair com um Snake Classic rodando dentro de um cluster."

---

## Slide 2 — Sobre mim (1 min)

> **Seja direto. Ninguém quer ouvir 5 minutos de currículo.**

"Rapidinho sobre mim: sou Emerson Silva, engenheiro DevOps/SRE na 4Linux há mais de 9 anos. Trabalho com Kubernetes no dia a dia — desde clusters de desenvolvimento até ambientes de missão crítica. Escrevo, dou aula e estou sempre na comunidade."

"O que vou mostrar hoje não é teoria de livro — é o que eu uso, o que eu erro e o que funciona."

---

## Slide 3 — Agenda (1 min)

"A jornada de hoje: começamos entendendo por que Kubernetes existe — que problema ele resolve. Depois mergulhamos em como ele funciona, quando faz sentido usá-lo, os principais objetos, e a gente fecha com um deploy real de um jogo clássico. Vai ter código, vai ter terminal, vai ser divertido."

_[gesticule para cada ponto]_

"Qualquer dúvida pode anotar — a gente abre para perguntas no final."

---

## Slide 4 — A evolução: bare metal → VMs → containers (3 min)

"Antes de falar de Kubernetes, preciso contextualizar de onde viemos."

"Era do bare metal: você comprava um servidor físico, esperava semanas para chegar, configurava na mão, e aquela máquina ficava ali por anos. Queria rodar dois sistemas no mesmo servidor? Problema — eles competiam por recursos, um podia derrubar o outro."

"Aí vieram as VMs. Com hypervisors como VMware e KVM, você conseguia ter múltiplos sistemas operacionais no mesmo hardware. Melhor. Mas cada VM carregava um SO completo — gigabytes de overhead."

"Containers mudaram o jogo. Ao invés de virtualizar hardware, você virtualiza o sistema operacional. O container compartilha o kernel do host mas tem seu próprio processo, rede e sistema de arquivos. Inicia em milissegundos. Ocupa megabytes."

"O problema: containers sozinhos são fáceis. Centenas deles em produção... é outra história."

---

## Slides 5 e 6 — O que é um container / Container vs VM (3 min)

"Antes de falar de Kubernetes, preciso ter certeza que todo mundo está na mesma página sobre o que é um container."

"Um container é um pacote que contém sua aplicação mais tudo que ela precisa para rodar: dependências, bibliotecas, variáveis de configuração. Tudo junto, isolado do resto do sistema."

"A analogia clássica é o container de navio — aquela caixa metálica padronizada. Não importa o que está dentro: eletrônico, roupa, alimento. O navio, o caminhão, o trem — todos conseguem transportar porque o formato é padrão. Container de software é a mesma ideia: empacota uma vez, roda em qualquer lugar."

"A diferença para a VM — que é a tecnologia anterior — está aqui no diagrama. A VM precisa de um sistema operacional completo por aplicação. São gigabytes de overhead. O container compartilha o kernel do host e carrega só o que é específico da aplicação. São megabytes. Inicia em milissegundos."

"Com isso claro, o problema de gerenciar muitos containers vai fazer mais sentido."

---

## Slide 7 — O problema de escala (2 min)

"Vamos tornar isso concreto. Imagina que você tem uma aplicação e ela roda em 10 containers. Tudo certo, você gerencia na mão."

"Agora a startup cresce. São 200 containers, em 8 servidores. Como você decide onde cada container vai rodar? Como você sabe se algum caiu? Quem reinicia? Como você atualiza sem derrubar o serviço? Como os containers de serviços diferentes se comunicam?"

"Fazer isso na mão é caos. Você precisa de um sistema que faça isso por você — automaticamente, de forma confiável."

"Esse sistema é o **orquestrador de containers**. E o mais popular é o Kubernetes."

---

## Slide 6 — É aqui que entra o Kubernetes (30 seg)

> **Pausa dramática. Deixe o slide respirar.**

"Guardem esse momento. Quando você entender o problema que o Kubernetes resolve, ele deixa de parecer magia e vira ferramenta."

---

## Slide 7 — Como surgiu o Kubernetes (3 min)

"A história começa no Google. Em 2003, eles criaram internamente um sistema chamado **Borg** — um orquestrador que gerenciava os jobs dentro dos data centers gigantes deles. Em 2011, o Borg já rodava mais de 2 bilhões de jobs por semana."

"Em 2013, engenheiros do Google — muitos deles que trabalharam no Borg — começaram a construir um projeto baseado nas lições aprendidas. Um orquestrador open source, projetado para o mundo externo."

"Em junho de 2014, o Kubernetes foi anunciado publicamente pelo Google. Em 2016, foi doado para a CNCF — Cloud Native Computing Foundation — e aí o projeto explodiu com contribuições de Red Hat, Microsoft, IBM, e centenas de outras empresas."

"Hoje Kubernetes é o padrão da indústria. Toda nuvem pública tem um serviço gerenciado de K8s — EKS na AWS, GKE no Google, AKS na Azure."

"O nome, aliás, vem do grego: timoneiro, piloto de navio. Faz sentido para um orquestrador de containers."

---

## Slide 8 — O que é Kubernetes (2 min)

"Definição formal: Kubernetes é um sistema open source de orquestração de containers que automatiza deploy, escalabilidade e gerenciamento de aplicações containerizadas."

"Na prática, a mentalidade é esta: você diz **o que quer** — 'quero 3 réplicas da minha aplicação rodando, com 512MB de memória cada' — e o Kubernetes cuida do **como**: em qual servidor coloca, como mantém vivo, como recupera se cair."

"Um ponto importante que sempre preciso repetir: **Kubernetes não substitui o Docker**. Docker cria e roda os containers. Kubernetes orquestra onde e como eles rodam. São ferramentas complementares."

---

## Slide 9 — Arquitetura: visão geral (3 min)

"Vamos entender como o Kubernetes é organizado internamente."

_[aponte para o diagrama]_

"Um cluster Kubernetes tem dois tipos de máquinas: o **Control Plane** e os **Worker Nodes**."

"O Control Plane é o cérebro — é ele que toma decisões. Os Worker Nodes são o músculo — é onde suas aplicações realmente rodam."

"Você como usuário fala com o Control Plane. O Control Plane instrui os Worker Nodes. Os Worker Nodes executam e reportam de volta."

---

## Slide 10 — Control Plane (2 min)

"Dentro do Control Plane temos quatro componentes principais."

"**API Server** — é a porta de entrada para tudo. Quando você roda `kubectl apply`, você está falando com o API Server. Toda interação com o cluster passa por aqui."

"**etcd** — banco de dados distribuído e consistente. Armazena o estado completo do cluster: quais pods existem, em quais nós estão, qual é o estado desejado. Se o etcd morrer, o cluster perde a memória."

"**Scheduler** — quando um novo Pod precisa ser criado, o Scheduler decide em qual Worker Node ele vai rodar, baseado em recursos disponíveis, afinidades e restrições."

"**Controller Manager** — é o fiscal. Fica comparando o estado real do cluster com o estado desejado e age para corrigir divergências. Você pediu 3 réplicas mas uma caiu? O Controller Manager percebe e sobe uma nova."

---

## Slide 11 — Worker Node (2 min)

"Nos Worker Nodes temos três componentes essenciais."

"**kubelet** — o agente que roda em cada nó. Recebe as instruções do Control Plane e garante que os containers estejam rodando conforme solicitado."

"**kube-proxy** — cuida das regras de rede. É responsável pelo roteamento de tráfego entre pods, mesmo que estejam em nós diferentes."

"**Container Runtime** — quem de fato executa os containers. O mais comum hoje é o **containerd** — o Docker Engine usa o containerd internamente."

> **Dica:** Se a plateia parecer engajada, faça uma pergunta: "Quem já instalou um cluster Kubernetes? Quem usou minikube ou kind?"

---

## Slide 12 — Quando usar Kubernetes (3 min)

"Uma coisa que ninguém te conta: Kubernetes não é para todo mundo, e tudo bem."

"Faz sentido quando: você tem muitos microsserviços para gerenciar, precisa de alta disponibilidade, escala horizontal frequente, times diferentes deployando em paralelo, ou portabilidade entre clouds é requisito."

"Talvez não precise quando: é um projeto pequeno ou MVP, o time é pequeno e sem experiência em K8s, um monólito simples resolve o problema, ou o custo operacional é uma restrição séria."

"Kubernetes adiciona complexidade. E complexidade tem custo — de aprendizado, de operação, de tempo. Se uma VM simples no DigitalOcean resolve o problema, use a VM simples."

_[pausa]_

"Mas quando você precisa de escala real e confiabilidade, não tem nada melhor."

---

## Slide 13 — Vantagens do Kubernetes (2 min)

"As vantagens que fazem o Kubernetes valer a curva de aprendizado:"

"**Self-healing** — container caiu? O K8s reinicia automaticamente. Nó morreu? Move os pods para outro nó. Você dorme tranquilo."

"**Auto-scaling** — Black Friday chegou, carga triplicou? Kubernetes escala seus pods horizontalmente. Carga caiu? Escala de volta. Automático."

"**Rolling updates** — quer atualizar a versão da sua app sem downtime? O K8s sobe as novas versões gradualmente enquanto mantém as antigas rodando."

"**Portabilidade** — seu cluster roda igual na AWS, no Google Cloud, na Azure ou no seu servidor on-premise. Sem lock-in."

---

## Slide 14 — Certificações (2 min)

"O mercado reconhece três certificações Kubernetes oficiais da CNCF."

"**CKAD** — Certified Kubernetes Application Developer. Foco em desenvolver e fazer deploy de aplicações no K8s. Ideal para devs que querem trabalhar com Kubernetes no dia a dia."

"**CKA** — Certified Kubernetes Administrator. Foco em administrar e operar clusters. É o que eu tenho. Para quem quer ser o cara que mantém o cluster rodando."

"**CKS** — Certified Kubernetes Security Specialist. Segurança em ambientes Kubernetes. Pré-requisito: ter a CKA."

"As três são práticas — você resolve problemas em um cluster real durante 2 horas. Nada de múltipla escolha. São reconhecidas globalmente e fazem diferença no currículo."

"Minha recomendação: CKAD se você é dev, CKA se você está no lado de infra/DevOps."

---

## Slide 15 — Transição: objetos (30 seg)

> **Pausa. Prepare o próximo bloco.**

"Vamos entrar nos objetos do Kubernetes. Eles são os blocos de construção de tudo que você vai fazer no cluster."

---

## Slide 16 — Pod (2 min)

"O **Pod** é a menor unidade do Kubernetes. Ele agrupa um ou mais containers que compartilham o mesmo endereço de rede e volume de armazenamento."

_[aponte para o YAML]_

"Aqui a gente define um Pod simples com um container nginx. Repara nos campos: `apiVersion`, `kind`, `metadata` e `spec`. Essa estrutura é padrão em todos os objetos do K8s."

"Mas atenção: na prática você quase nunca cria Pods diretamente. Se um Pod morre, ele não volta sozinho — você precisa de um objeto que faça essa gestão."

"Esse objeto é o **Deployment**."

---

## Slide 17 — Deployment (3 min)

"O **Deployment** é como você gerencia seus Pods no Kubernetes. Você declara quantas réplicas quer e qual imagem usar — o K8s cuida do resto."

_[percorra o YAML linha por linha]_

"`replicas: 3` — eu quero três instâncias da minha aplicação rodando."

"`selector.matchLabels` — como o Deployment identifica quais Pods são dele."

"`template` — o molde do Pod que vai ser criado. Tudo dentro do template.spec é a definição do container."

"Se um Pod morrer, o Deployment recria. Se você quiser escalar, muda o número de réplicas. Se quiser atualizar a imagem, muda o campo `image` e o K8s faz o rolling update."

---

## Slide 18 — Service (3 min)

"Pods têm IPs dinâmicos — quando um Pod morre e outro nasce no lugar, o IP muda. Como você acessa uma aplicação com IP que muda toda hora?"

"Esse é o problema que o **Service** resolve. Ele cria um ponto de acesso estável — um nome e um IP fixo — que roteia o tráfego para os Pods corretos."

_[aponte para o YAML]_

"`selector: app: meu-app` — o Service encaminha para todos os Pods com esse label."

"Os três tipos que você vai usar:"

"**ClusterIP** — só acessível de dentro do cluster. Padrão."

"**NodePort** — expõe uma porta em cada nó do cluster. Útil para desenvolvimento."

"**LoadBalancer** — provisiona um load balancer externo na nuvem. Usado em produção."

---

## Slide 19 — Namespace (2 min)

"**Namespaces** são a forma de dividir o cluster logicamente. Pense como pastas — você organiza recursos relacionados no mesmo namespace e isola times ou ambientes entre si."

"Por padrão o K8s cria alguns namespaces: `default` para seus recursos, `kube-system` para os componentes internos do K8s."

"Uma prática comum é ter um namespace por ambiente: `dev`, `staging`, `producao`. Ou um por time. Vai do que fizer sentido para a organização."

"Quando você não especifica namespace, o recurso vai para o `default`."

---

## Slide 20 — ConfigMap e Secret (2 min)

"Boas práticas de desenvolvimento pedem que você separe a configuração do código. No Kubernetes temos dois objetos para isso."

"**ConfigMap** — para configurações não-sensíveis. Variáveis de ambiente, arquivos de configuração. Em texto puro."

"**Secret** — para dados sensíveis: senhas, tokens, chaves de API. Os dados são armazenados em base64 — atenção: isso é **encoding**, não criptografia. Para criptografia real, use soluções como Sealed Secrets ou Vault."

"Ambos podem ser injetados nos containers como variáveis de ambiente ou montados como arquivos."

---

## Slide 21 — Transição para demo (30 seg)

> **Momento de energia. A plateia vai animar.**

"Chega de teoria. Vamos colocar a mão na massa e rodar algo divertido."

"Vamos fazer o deploy do Snake Classic Bros — um projeto open source que empacota o jogo inteiro numa imagem Docker — dentro de um cluster Kubernetes."

---

## Slide 22 — YAML do Deployment (2 min)

_[abra o terminal ao lado dos slides se possível]_

"Esse é o Deployment do Snake Classic. A imagem é `silvemerson/docker-snake` — uma imagem pública que roda o jogo em Java, escutando na porta 8080."

"`replicas: 1` — uma réplica é suficiente para o demo."

"O label `app: docker-snake` vai ser usado pelo Service para encontrar este Pod."

---

## Slide 23 — YAML do Service (1 min)

"O Service do tipo `NodePort` expõe o deployment para fora do cluster."

"`targetPort: 8080` — a porta onde o container escuta."

"`port: 80` — a porta que o Service expõe internamente."

"O Kubernetes vai atribuir automaticamente uma porta acima de 30000 nos nós — é por ela que você vai acessar o jogo."

---

## Slide 24 — Comandos no terminal (3 min)

> **Faça ao vivo se tiver ambiente disponível.**

```bash
kubectl apply -f docker-snake.yaml
kubectl apply -f docker-snake-service.yaml
kubectl get pods -w
kubectl get service docker-snake
kubectl port-forward service/docker-snake 8080:80
```

"Repara no `kubectl get pods -w` — o `-w` é de watch. Você vê o Pod passando de `Pending` para `ContainerCreating` para `Running` em tempo real."

"Com o port-forward ativo, basta abrir `http://localhost:8080` no navegador."

_[abra o navegador e jogue alguns segundos — a plateia vai aplaudir]_

---

## Slide 25 — O que aconteceu por baixo dos panos (2 min)

"Vamos destrinchar o que aconteceu quando você rodou o `kubectl apply`."

_[percorra o fluxo linha por linha]_

"Você enviou o YAML para o API Server. Ele validou e salvou no etcd como 'estado desejado'."

"O Scheduler viu que há um novo Pod sem nó atribuído. Escolheu um Worker Node disponível."

"O kubelet naquele nó recebeu a instrução, falou com o containerd, que fez pull da imagem do Docker Hub e iniciou o container."

"O kube-proxy configurou as regras de rede para que o NodePort funcionasse."

"E o Service passou a rotear o tráfego da porta 80 para a 8080 do Pod."

"Tudo isso em segundos. Declarativo. Automático."

---

## Slide 26 — Conclusão (2 min)

"Chegamos ao fim. O que você precisa levar daqui:"

"Kubernetes surgiu do Borg do Google, virou open source em 2014 e hoje é o padrão para orquestração de containers."

"Ele resolve o problema de gerenciar muitos containers em escala: onde rodam, como sobrevivem, como escalam, como se comunicam."

"Os objetos principais: Pod, Deployment, Service, Namespace, ConfigMap, Secret. Com esses seis você constrói a maioria das aplicações."

_[pausa]_

"O próximo passo prático: instala o **minikube** ou usa o **killercoda.com** — você tem um cluster real no navegador, de graça. Tenta replicar o deploy do Snake Classic por conta própria."

---

## Slide 27 — Obrigado (Q&A)

"Obrigado pela atenção!"

"Os recursos que deixei no slide são os que eu recomendo de verdade: a documentação oficial do Kubernetes é excelente, o killercoda tem labs práticos sem precisar instalar nada, e a Linux Foundation tem os cursos oficiais para as certificações."

_[aponte para o QR code]_

"O QR code leva para os slides. Podem me encontrar no blog e no @silvemerson no Twitter."

"Vamos abrir para perguntas."

---

## Perguntas frequentes — prepare-se

**"Qual a diferença entre Docker e Kubernetes?"**
> Docker cria e executa containers em uma máquina. Kubernetes orquestra containers em múltiplas máquinas. São complementares: o K8s usa o Docker (ou outro runtime) por baixo.

**"Precisa saber Docker antes de aprender Kubernetes?"**
> Sim, o básico. Entender o que é uma imagem, um container, como funciona o Dockerfile — esses conceitos são pré-requisito para o K8s fazer sentido.

**"Kubernetes é caro?"**
> Depende. Kubernetes em si é open source e gratuito. O custo vem da infraestrutura (servidores) e do serviço gerenciado se você usar EKS, GKE ou AKS. Para aprender, minikube e kind rodam no seu notebook de graça.

**"Posso usar Kubernetes on-premise?"**
> Sim. Distribuições como K3s, Rancher e OpenShift funcionam em hardware próprio. É mais trabalho operacional do que usar um serviço gerenciado de nuvem, mas é totalmente viável.

**"Por onde começo a estudar?"**
> killercoda.com para prática gratuita. kubernetes.io/docs tem um tutorial de 'Hello Minikube' excelente. Para certificações, o treinamento oficial da Linux Foundation.

**"Qual certificação fazer primeiro?"**
> CKAD se você é desenvolvedor, CKA se está em infra/DevOps/SRE. As duas se complementam — muita gente faz as duas.

---

## Dicas finais de apresentação

- **Postura:** Fique de pé, mova-se pelo palco. Não fique estático atrás do computador.
- **Contato visual:** Varre a sala. Não fale olhando para o slide.
- **Velocidade:** Fale mais devagar do que parece necessário. Quando nervoso, a tendência é acelerar.
- **Demo ao vivo:** Se for fazer o deploy, tenha o minikube já iniciado. `minikube start` na frente do público é chato e pode dar erro.
- **Perguntas durante a fala:** Se alguém interromper com dúvida genuína, responda. Engaja a plateia.
- **Tempo:** Se sobrar tempo, aprofunde a parte de arquitetura ou mostre `kubectl describe pod`. Se faltar, o slide de ConfigMap/Secret pode ser acelerado.
