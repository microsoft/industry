# Engineering Principles - reference implementations for Industry Clouds

## *Customer Architecture Team, September 2021*

## Intro

Microsoft Cloud for industries are a set of solutions tailored to specific industries and where the resource composition spans across Azure, M365, Power Platform – including D365.
From a layering perspective, the industry specific solutions are at the top of the stack, making core assumptions that the foundational infrastructure, security, compliance, connectivity, identity and more, is present across the various Microsoft clouds for the organization.
However, there’s no such thing as a reference implementation that 1) spans across the Microsoft clouds, and 2) that have been validated with and by customers, and 3) vetted by engineering teams.

This gap ultimately slows down the field, and our customers in order to realize value faster, and there’s a very high risk that customers are left with something that is bespoke and are facing a cliff as we continue to develop our clouds and offerings in the industry space.

### What must be true?

CAT must provide the core cloud foundation for each of our cloud platforms, to ensure the industry solutions will land on something that is sustainable, aligned with the platform and product roadmap(s), and anchored on core design principles across critical design areas for the respective cloud platforms.
The goal of the reference implementations is to accelerate and expedite the customer journey and help them to realize value much faster vs what’s feasible today, due to the lack of a cohesive approach to the industry clouds.

In parallel with the cloud foundations, we will develop and ship industry specific solutions in partnership with the respective engineering teams, while improving the overall platform.

This document will outline the core principles and approach for the engineering effort for CAT to provide reference implementations for the industry clouds and solutions with the highest quality.

### Core principles

We assert that it is essential for CAT to coalesce around a central strategy for how we are approaching the reference implementations.
There’s no single, common management endpoint nor control plane for the resources that spans our clouds, which makes it more complex to unify and streamline the approach. However, with some guiding principles, we aim for the optimal starting point given the state of the union(s) and align with the future direction for each of our clouds.

#### [Azure as the anchor]

In all industry clouds and respective solutions, Azure plays a pivotal role in the overall architecture and data flow. For each reference implementation that starts with – or requires Azure components, we will lead with Azure Resource Manager and Azure Portal to provide the first-party implementation that allows for the most optimal and curated customer experience. This applies to both cloud foundations as well as individual solutions. For deployments and configuration across other clouds when starting from Azure, we will take a dependency on ARM’s and Portal extensibility mechanisms.

#### [Singular entity control plane]

For everything but Azure, we will leverage and honour the control plane responsible for the entities in the respective platforms in our reference implementations, and not preclude with unnecessary CRUD by Azure Resource Manager. These implementations and solutions must be developed so they can operate and function without the Azure context, as well as be consumed by Azure when Azure being the anchor.
Phased approach
As we are early on the journey of industry clouds and reference implementations that spans across our Microsoft clouds, we will approach this in a pragmatic fashion, and not try to ‘do it all – at once’.
Our reference implementations will primarily accelerate adoption and customers journey towards the optimal starting point, serve as a manifest to any architectural and design methodology and our artifacts should - initially be seen as a means to an end, and not being the day-to-day value generation for operations and maintenance. More specifically, we provide implementations, but will initially leave out CI/CD and other operational dimensions, while continue learning with our customers and closely observe the direction and development of the respective platforms.
The following phased approach is suggested, subject to changes while the platforms and roadmaps evolves as well as capturing key insights and learnings from other parties at Microsoft and our customers:

* [Phase 1]. Architectures, composition and deployments

To accelerate innovation, adoption, and usage, we will center on the principles of Azure as the anchor, and single entity control plane to achieve end-2-end implementations, while also solving for execution in isolation. In parallel when settling the core foundations, the same focus will apply to the industry solutions.
A critical outcome of phase 1 is to share all learnings with key stakeholders in engineering, address gaps, blockers, and focus to tackle the customer experiences

* [Phase 2]. CI/CD patterns and implementations

For Azure, we have leveraged AzOps for Azure platform and it’s designed to be agnostic to deployment scopes – both for platform and applications. For M365 there’s already a momentum and great adoption of a Desired-State Configuration composition that allows organizations to manage their M365 tenant declaratively using PowerShell DSC. We should aim to learn more to see if this can be representative in the overall CICD approach for M365. For Power Platform, we do not have anything equivalent of AzOps for Azure or DSC for M365 and will work with the PG to understand roadmap and platform direction to have a better understanding of our investments compared to customer demands.
