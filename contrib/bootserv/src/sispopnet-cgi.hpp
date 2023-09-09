#ifndef BOOTSERV_SISPOPNET_CRON_HPP
#define BOOTSERV_SISPOPNET_CRON_HPP

#include "handler.hpp"

namespace sispopnet
{
  namespace bootserv
  {
    struct CGIHandler final : public Handler
    {
      CGIHandler(std::ostream& o);
      ~CGIHandler();

      int
      Exec(const Config& conf) override;

      int
      ReportError(const char* err) override;

      int
      ServeFile(const char* fname, const char* mime) const;

      std::string
      PickRandomFileInDir(std::string dirname) const;
    };

  }  // namespace bootserv
}  // namespace sispopnet

#endif
