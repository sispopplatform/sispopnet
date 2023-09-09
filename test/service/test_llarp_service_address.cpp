#include <service/address.hpp>

#include <gtest/gtest.h>

struct ServiceAddressTest : public ::testing::Test
{
  const std::string snode =
      "8zfiwpgonsu5zpddpxwdurxyb19x6r96xy4qbikff99jwsziws9y.snode";
  const std::string sispop =
      "7okic5x5do3uh3usttnqz9ek3uuoemdrwzto1hciwim9f947or6y.sispop";
  const std::string sub = "sispopnet.test";
  const std::string invalid =
      "7okic5x5do3uh3usttnqz9ek3uuoemdrwzto1hciwim9f947or6y.net";
};

TEST_F(ServiceAddressTest, TestParseBadTLD)
{
  llarp::service::Address addr;
  ASSERT_FALSE(addr.FromString(snode, ".net"));
  ASSERT_FALSE(addr.FromString(invalid, ".net"));
}

TEST_F(ServiceAddressTest, TestParseBadTLDAppenedOnEnd)
{
  llarp::service::Address addr;
  const std::string bad = sispop + ".net";
  ASSERT_FALSE(addr.FromString(bad, ".net"));
}

TEST_F(ServiceAddressTest, TestParseBadTLDAppenedOnEndWithSubdomain)
{
  llarp::service::Address addr;
  const std::string bad = sub + "." + sispop + ".net";
  ASSERT_FALSE(addr.FromString(bad, ".net"));
}

TEST_F(ServiceAddressTest, TestParseSNodeNotSispop)
{
  llarp::service::Address addr;
  ASSERT_TRUE(addr.FromString(snode, ".snode"));
  ASSERT_FALSE(addr.FromString(snode, ".sispop"));
}

TEST_F(ServiceAddressTest, TestParseSispopNotSNode)
{
  llarp::service::Address addr;
  ASSERT_FALSE(addr.FromString(sispop, ".snode"));
  ASSERT_TRUE(addr.FromString(sispop, ".sispop"));
}

TEST_F(ServiceAddressTest, TestParseSispopWithSubdomain)
{
  llarp::service::Address addr;
  const std::string addr_str = sub + "." + sispop;
  ASSERT_TRUE(addr.FromString(addr_str, ".sispop"));
  ASSERT_EQ(addr.subdomain, sub);
  ASSERT_EQ(addr.ToString(), addr_str);
};

TEST_F(ServiceAddressTest, TestParseSnodeWithSubdomain)
{
  llarp::service::Address addr;
  const std::string addr_str = sub + "." + snode;
  ASSERT_TRUE(addr.FromString(addr_str, ".snode"));
  ASSERT_EQ(addr.subdomain, sub);
  ASSERT_EQ(addr.ToString(".snode"), addr_str);
};
