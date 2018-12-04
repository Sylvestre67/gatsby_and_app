import React from 'react'
import { Link } from 'gatsby'

import Layout from '../components/layout'
import Image from '../components/image'

const IndexPage = () => (
  <Layout>
    <h1>Hi people</h1>
    <p>Welcome to your new Gatsby site.</p>
    <p>Now go build something great.</p>
    <div style={{ maxWidth: '300px', marginBottom: '1.45rem' }}>
      <Image />
    </div>
    <Link to="/page-2/">Go to page 2</Link>
    <ul>
      <li>
        <a href="/alpha/">Alpha</a>
      </li>
      <li>
        <a href="/beta/">Beta</a>
      </li>
    </ul>
  </Layout>
)

export default IndexPage
